#include <Rcpp.h>
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

//' Calculate the euclidean distance between 2 points
//'
//' @param x1 A numeric vector of the coordinates of x1 point.
//' @param x2 A numeric vector of the coordinates of x2 point.
//' @param size A integer of the length of x1 or/and x2.
//' @export
// [[Rcpp::export]]
double cppdist(NumericVector x1, NumericVector x2, double size){
  double sum = 0;
  for(int i=0; i<size; i++){
    sum += (x1[i] - x2[i]) * (x1[i] - x2[i]);
  }
  return sum;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
cppdist(c(1,1), c(2,2), 2)
*/
