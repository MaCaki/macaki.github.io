require 'open3'
#require 'jekyll-pandoc-multiple-formats/version'

module Jekyll

class PdfCVGenerator < Generator

  def compileCV(site, cv)

    ## Render the CV.tex template and get the content minus the Front Matter
    latex_cv_file_path = cv.path
    latex_cv_content = (Liquid::Template.parse(cv.content)).render(site.site_payload)
    subject = cv['subject']

    ## Write out a compileable .tex file to pass to 'pdflatex'
    texfile_name = 'cv_' + subject + '_compiled.tex'
    out_dir = File.dirname(File.dirname(latex_cv_file_path)) + '/assets/'

    tmp_filename_path =  File.dirname(latex_cv_file_path) + '/tmp/' + texfile_name

    tmp_file = open(tmp_filename_path, 'w')
    tmp_file.write(latex_cv_content)
    tmp_file.close

    cmd = "pdflatex " + "-output-directory=\"#{out_dir}\" " + " \"#{tmp_filename_path}\""

    Open3.popen2(cmd) {|stdin, stdout, wait_thr|
      result = stdout.read # pid of the started process.
      exit_status = wait_thr.value # Process::Status object returned.
      p result
    }

    outfile_name = texfile_name.chomp('tex') + 'pdf'
    site.static_files << StaticFile.new(site, site.source, 'assets/', "cv_compiled.pdf")
  end

  def generate(site)
    puts "Generating PDF"
    @CVs = site.collections['cv'].docs.find_all { |c| c['format'] == 'latex' }

    for cv in @CVs
      puts cv['subject']
      compileCV(site, cv)
    end

  end
end

end
