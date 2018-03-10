The project is for interpolating wind field. The main idea of this project is multi kernel,
which could extract multi-scale dependencies of weather process.

1.  Toolbox

 GAUSSIAN PROCESS REGRESSION AND CLASSIFICATION Toolbox version 4.0
    for GNU Octave 3.2.x and Matlab 7.x

Copyright (c) by Carl Edward Rasmussen and Hannes Nickisch, 2016-10-19.

2.  details
Most of this part is come from Carl Edward's README.md

There are 8 code subdirectories: moi_prac, cov, doc, inf, lik, mean, prior and util.

moi_prac/ The main project file for interpolation

cov/      contains covariance functions cov*.m
          => see covFunctions.m

doc/      contains an index.html file providing documentation. This information
          is also available from http://www.GaussianProcess.org/gpml/code.
          Usage of mean, cov, classification and regression is demonstrated
          in usage*.m. Further details can be found in the developer
          documentation manual.pdf.

inf/      contains the inference algorithms inf*.m
          => see infMethods.m

lik/      contains the likelihood functions lik*.m
          => see likFunctions.m

mean/     contains the mean functions mean*.m
          => see meanFunctions.m

prior/    contains the hyperparameter prior distributions prior*.m
          => see priorDistributions.m

util/     contains optimisation routines, backward compatibility programs and
          small auxiliary scripts

3.  Reference
    Carl Edward Rasmussen. Gaussian process for Machine Learning