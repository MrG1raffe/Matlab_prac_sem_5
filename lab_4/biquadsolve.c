#include <math.h>
#include "mex.h"
#include <complex.h>
#include <stdio.h>
#include "matrix.h"

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )
     
{ 
    if (nrhs != 3) { 
	    mexErrMsgIdAndTxt( "MATLAB:yprime:invalidNumInputs",
                "Three input arguments required."); 
    } else if (nlhs > 4 || nlhs < 2) {
	    mexErrMsgIdAndTxt( "MATLAB:yprime:maxlhs",
                "Number of output arguments should be between 2 and 4."); 
    } 
    
    int m = mxGetM(prhs[0]); 
    int n = mxGetN(prhs[0]);
    for(int i = 0; i < 4; i++)
    {
    	plhs[i] = mxCreateDoubleMatrix( (mwSize)m, (mwSize)n, mxCOMPLEX); 
    }
    mxComplexDouble *A, *B, *C;
    A = (mxComplexDouble*) mxGetComplexDoubles(prhs[0]);
    B = (mxComplexDouble*) mxGetComplexDoubles(prhs[1]);
    C = (mxComplexDouble*) mxGetComplexDoubles(prhs[2]);
   
    mxComplexDouble* res[4];
    for (int i = 0; i < 4; i++)
    {
       res[i] = (mxComplexDouble *)mxGetComplexDoubles(plhs[i]);
    }
    complex a, b, c, x[4] = {0, 0, 0, 0};

    for (int i = 0; i < m * n; i++)
    {
        a = A[i].real + I * A[i].imag; 
        b = B[i].real + I * B[i].imag; 
        c = C[i].real + I * C[i].imag; 
        
        if (a == 0) {
            x[0] = csqrt(-c / b);
            x[1] = -x[0];
            x[2] = x[3] = x[1];
        } else {
            x[0] = csqrt((-b + csqrt(b * b - 4 * a * c)) / (2 * a));
            x[1] = -x[0];
            x[2] = csqrt((-b - csqrt(b * b - 4 * a * c)) / (2 * a));
            x[3] = -x[2];
        }
        
        for(int j = 0; j < 4; j++)
        {
            res[j][i].real = creal(x[j]);
            res[j][i].imag = cimag(x[j]);
        }
    }
    return;
}
