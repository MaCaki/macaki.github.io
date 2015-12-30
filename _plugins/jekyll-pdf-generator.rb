require 'open3'
#require 'jekyll-pandoc-multiple-formats/version'

module Jekyll

class PdfCVGenerator < Generator
  def generate(site)
    puts "Generating PDF"

    cv = site.collections['cv'].docs.find { |c| c['format'] == 'latex' }

    ## Render the CV.tex template and get the content minus the Front Matter
    latex_cv_file_path = cv.path

    latex_cv_content = (Liquid::Template.parse(cv.content)).render(site.site_payload)



    ## Write out a compileable .tex file to pass to 'pdflatex'
    out_dir = latex_cv_file_path.chomp('_cv/cv.tex') + 'assets/'

    tmp_filename_path =  latex_cv_file_path.chomp('cv.tex') + 'cv_compiled.tex'

    tmp_file = open(tmp_filename_path, 'w')
    tmp_file.write(latex_cv_content)
    tmp_file.close

    cmd = "pdflatex " + "-output-directory=\"#{out_dir}\" " + " \"#{tmp_filename_path}\""

    #Open3.popen3(cmd) 

    Open3.pipeline(cmd)

    site.static_files << StaticFile.new(site, site.source, 'assets/', "cv_compiled.pdf")

  end
end

end
