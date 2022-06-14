# OHBM2022

This repository is a companion for Noah C. Benson's OHBM 2022 Educational
Course. The course introduces a number of software tools that are useful in the
analysis of structure and function in neuroimaging work. The tutorials and
resources documented below context and instructions on using these tools.

## Introductory Resources

These resources are not necessarily related to the OHBM talk, but they provide
useful introductory context for those who are newly learning the neuroimaging
software environment.

* [Software Carpentry](https://software-carpentry.org/lessons). The Carpentries
  is a not-for-profit organization that creates introductory data science
  tutorials on a variety of topics. Their lessons (linked) include an
  introduction to the UNIX/POSIX shell, using `git` and GitHub, Python, and
  R. For those who are new to the shell, `git`, or Python, these tutorials are a
  recommended starting place. The
  [setup instructions](http://swcarpentry.github.io/python-novice-gapminder/setup.html)
  for the Python lesson provide information on installing Python and JupyterLab,
  which can be used to view the notebook tutorials (files with `.ipynb` endings,
  usually). Note that recordings of many of these tutorials are available on
  YouTube (search for "software carpentry").
* [The Python Datascience Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/). 
  This book by Jake VanderPlas is an excellent resource for learning valuable
  and useful data science techniques in Python. Anyone who is new to Python or
  who is new to data science should strongly consider this book, which is freely
  available online as a set of Jupyter notebooks on GitHub.
* [MRI Geometry](https://nben.net/MRI-Geometry/). This tutorial is slightly
  out-dated, but it is still very useful for understanding the basics of
  cortical geometry and how neuroscience software tends to represent the
  structural data from MRI scans.
* **Retinotopic Maps**. Each visual area has a retinotopic map, that is, a
  mapping of the retina onto the visual field. Retinotopic maps are determined
  by solving what is called a "population receptive field" (pRF) model for each
  voxel in the visual cortex. The pRF model explains the BOLD respons in terms
  of the visual stimulus during an fMRI experiment. These resources are related
  to retinotopic maps and may be useful for understanding them.
  * [VistaSoft PRF Tutorial](https://web.stanford.edu/group/vista/cgi-bin/wiki/index.php/Retinotopy_Tutorial).
    This tutorial on the VistaSoft suite (for Matlab) to solve pRF models and to
    analyze retinotopic maps.
  * [mrTools PRF Tutorial](https://gru.stanford.edu/doku.php/mrtools/tutorialsprf).
    This tutorial is similar to the above tutorial, but is for the mrTools suite
    (also for Matlab).
  * [popeye](https://kdesimone.github.io/popeye/). Popeye is a Python tool for
    solving retinotopic maps; although this link is not a tutorial, it is a
    useful start page for this tool and includes links to documentation.
* [Andy's Brain Book](https://andysbrainbook.readthedocs.io/). This collection
  of tutorials (including videos for most) by Andy Jahn is incredibly valuable
  and is referenced frequently below.


## Resources Related to the OHBM 2022 Talk

* Data Processing
  * [fMRIprep](https://fmriprep.org/). I recommend the fMRIprep sequence of
    tutorials from [Andy's Brain Book](https://andysbrainbook.readthedocs.io/en/latest/fMRI_Short_Course/fMRI_Intro.html).
    These tutorials are comprehensive and include example data and videos.
    [This tutorial](https://medium.com/@gelana/using-fmriprep-for-fmri-data-preprocessing-90ce4a9b85bd)
    by Gelana Tostaeva walks through a different analysis scenario and may also
    be useful.
  * [FreeSurfer](https://surfer.nmr.mgh.harvard.edu/). Once again, the
    [FreeSurfer tutorial from Andy's Brain Book](https://andysbrainbook.readthedocs.io/en/latest/FreeSurfer/FreeSurfer_Introduction.html)
    is an excellent starting place for learning how to use
    FreeSurfer. Additionally, FreeSurfer has its own comprehensive collection of
    tutorials, which can be found [here](https://surfer.nmr.mgh.harvard.edu/fswiki/Tutorials).
* Data Sharing
  * [Brain Imagine Data Structure (BIDS)](https://bids.neuroimaging.io/). The
    [BIDS tutorial](https://reproducibility.stanford.edu/bids-tutorial-series-part-1a/)
    from the [Stanford Center for Reproducible Neuroscience](https://reproducibility.stanford.edu/)
    along with the [BIDS Starter Kit](https://bids-standard.github.io/bids-starter-kit/)
    are probably the best places to start learning about BIDS.
  * [OpenNeuro.org](https://openneuro.org/). I recommend the
    [OpenNeuro user guide](https://docs.openneuro.org/user-guide) for learning
    about this website and how to use it. Additionally, the
    [INCF Training Space tutorials](https://training.incf.org/course/openneuroorg-tutorials)
    may be useful for learning about how to upload data to OpenNeuro.
* Data Access and Manipulation
  * [DataLad](https://www.datalad.org/). An comprehensive registry of DataLad
    tutorials can be found at the GitHub repository
    [datalad/tutorials](https://github.com/datalad/tutorials).
  * [Neuropythy](https://github.com/noahbenson/neuropythy). A variety of
    tutorials for Neuropythy can be found in the GitHub repository
    [noahbenson/neuropythy-tutorials](https://github.com/noahbenson/neuropythy-tutorials).
    
