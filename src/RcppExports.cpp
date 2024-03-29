// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

// cppdist
double cppdist(NumericVector x1, NumericVector x2, double size);
RcppExport SEXP _package1_cppdist(SEXP x1SEXP, SEXP x2SEXP, SEXP sizeSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x1(x1SEXP);
    Rcpp::traits::input_parameter< NumericVector >::type x2(x2SEXP);
    Rcpp::traits::input_parameter< double >::type size(sizeSEXP);
    rcpp_result_gen = Rcpp::wrap(cppdist(x1, x2, size));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_package1_cppdist", (DL_FUNC) &_package1_cppdist, 3},
    {NULL, NULL, 0}
};

RcppExport void R_init_package1(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
