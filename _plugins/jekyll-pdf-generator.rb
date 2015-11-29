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

    ## Write out a compileable .tex file to pass to 'pdflatex'
    out_dir = latex_cv_file_path.chomp('cv.tex') + '/out/'
    cmd = 'mkdir ' + out_dir
    Open3.pipeline(cmd)
    tmp_filename_path = out_dir + 'cv_tmp.tex'

    tmp_file = open(tmp_filename_path, 'w')
    tmp_file.write(latex_cv_content)
    tmp_file.close

    cmd = "pdflatex " + "-output-directory=\"#{out_dir}\" " + " \"#{tmp_filename_path}\""

    # Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
    #   pid   = wait_thr.pid 
    #   stdout.gets
    #   error = stderr.gets
    #   exit  = wait_thr.value
    # end

    Open3.pipeline(cmd)

    site.static_files << StaticFile.new(site, base_dir, '_cv/out/', "cv_tmp.pdf")

  end
end

end
