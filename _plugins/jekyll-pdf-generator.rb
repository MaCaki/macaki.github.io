require 'open3'
#require 'jekyll-pandoc-multiple-formats/version'

module Jekyll

class PdfCVGenerator < Generator
  def generate(site)
    outputs = site.config['pandoc']['outputs']
    flags  = site.config['pandoc']['flags']

    base_dir = site.source 

    puts "Generating PDF"
    puts site.source

    cv = site.collections['cv'].find { |c| c['format'] == 'latex' }

    ## Render the CV.tex template and get the content minus the Front Matter
    latex_cv_file_path = cv.path
    latex_cv_content = (Liquid::Template.parse(cv.content)).render(site.site_payload)

    tmp_file_dir = latex_cv_file_path.chomp('cv.tex')
    tmp_file_path = latex_cv_file_dir + 'cv_tmp.tex'

    ## Write out a compileable .tex file to pass to 'pdflatex'
    tmp_file = open(tmp_file_path, 'w')
    tmp_file.write(latex_cv_content)
    tmp_file.close

    cmd = "pdflatex " + "-output-directory=\"#{tmp_file_dir}\" " + " \"#{tmp_file_path}\""

    Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
      pid   = wait_thr.pid 
      stdout.gets
      error = stderr.gets
      exit  = wait_thr.value
    end

    #Open3.pipeline(cmd)

    site.static_files << StaticFile.new(site, base_dir, '_cv', "cv_tmp.pdf")

  end
end

end
