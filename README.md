# Personal Academic/Resume Site with automatic Latex pdf generation

This is my personal site build using **Jekyll**.  It makes heavy use of the _Collections_ feature of Jekyll to organize the various components of a standard resume in a reusable way.   The jekyll-pdf-generator plugin renders and compiles a .tex template of the CV portion of the site and compiles it using pdflatex to output a pdf file that the final site can link to.  

This framework allows me to write content once, and have both an html and a cleanly formatted LaTex pdf version of my resume.  Whenver I want to add new content, i.e. a job, project, eduction, or paper, I can make a new markdown file and it will be automaticall compiled into the html site as well as the pdf.  This framework also allows for generating differnt versions of the resume by picking content based on custom variables such as 'category => 'teaching''. 


---

##note
Since github only builds Jekyll sites in 'safe' mode, the site has to be build locally to generate the pdf. Also pdflatex has to be installed.     


---

##TODO

* work on layout of teaching section 

* add graphics to the math portion. 

* Search for and add page about generalized permutohedra. 
