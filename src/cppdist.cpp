#include <Rcpp.h>
#include <math.h>
using namespace Rcpp;

// This is a simple example of exporting a C++ function to R. You can
// source this function into an R session using the Rcpp::sourceCpp
// function (or via the Source button on the editor toolbar). Learn
// more about Rcpp at:
//
//   http://www.rcpp.org/
//   http://adv-r.had.co.nz/Rcpp.html
//   http://gallery.rcpp.org/
//

// [[Rcpp::export]]
double cppdist(NumericVector x1, NumericVector x2, double size){
  double sum = 0;
  for(int i=0; i<size; i++){
    sum += (x1[i] - x2[i]) * (x1[i] - x2[i]);
  }
  return sqrt(sum);
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
cppdist(c(1,1), c(2,2), 2)
*/
