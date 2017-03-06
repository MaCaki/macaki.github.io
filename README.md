# Personal CV Site with automatic Latex pdf compilation. 

This is my personal site build using **Jekyll**.  It makes heavy use of the `_Collections_` feature of Jekyll to organize the various components of a standard resume in a reusable way.   The `jekyll-pdf-generator` plugin renders and compiles a .tex template of the CV portion of the site and compiles it using pdflatex to output a pdf file that the final site can link to.  

This framework allows me to write content once, and have both an html and a cleanly formatted LaTex pdf version of my resume.  Whenver I want to add new content, i.e. a job, project, eduction, or paper, I can make a new markdown file and it will be automaticall compiled into the html site as well as the pdf.  This framework also allows for generating differnt versions of the resume by picking content based on custom variables such as 'category => 'teaching''. 


## Developing 

To update content checkout the branch `working-source` then checkout a feature branch off of it. Once the content is done merge back into the `working-source` branch, **not into master**.

To add a new piece of content to a category (for example, a paper), create a new `.md` file in the folder `_{category}`, following the format of a [data file](https://jekyllrb.com/docs/datafiles/)

### Compiling site
Once the `working-source` branch is updated run `rake`, which will run Jekyll to make the site, then merge the contents of `/site` into master. 

---

##note
Since github only builds Jekyll sites in 'safe' mode, the site has to be build locally to generate the pdf. Also pdflatex has to be installed.     


---

##TODO

* work on layout of teaching section 

* add graphics to the math portion. 

* Search for and add page about generalized permutohedra. 
