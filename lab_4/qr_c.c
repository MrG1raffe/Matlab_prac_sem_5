#include <math.h>
#include "mex.h"
#include <stdio.h>

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] )
     
{ 
    if (nrhs != 1) { 
	    mexErrMsgIdAndTxt( "MATLAB:yprime:invalidNumInputs",
                "There should be one input argument."); 
    } else if (nlhs > 2 || nlhs < 1) {
	    mexErrMsgIdAndTxt( "MATLAB:yprime:maxlhs",
                "There should be one or two output arguments."); 
    } 
    
    int m = mxGetM(prhs[0]); 
    int n = mxGetN(prhs[0]);
    if (m != n) {
	    mexErrMsgIdAndTxt( "MATLAB:yprime:maxlhs",
                "A should be square.");       
    }
    plhs[0] = mxCreateDoubleMatrix((mwSize)m, (mwSize)n, mxREAL); 
    plhs[1] = mxCreateDoubleMatrix((mwSize)m, (mwSize)n, mxREAL); 
    double *Q = mxGetPr(plhs[0]);
    double *R = mxGetPr(plhs[1]);
    double *A = mxGetPr(prhs[0]);
    for (int i = 0; i < n; i++)
    {
        R[i * (n + 1)] = 1;
    }
    double c[n];
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            c[j] = 0;
        }
        for (int j = 0; j < i; j++)
        {
            double ab = 0, bb = 0;
            for (int k = 0; k < n; k++)
            {
                ab += A[i * n + k] * Q[j * n + k];
                bb += Q[j * n + k] * Q[j * n + k];
            }
            double d = ab / bb;
            R[i * n + j] = d;
            for (int k = 0; k < n; k++)
            {
                c[k] += d * Q[j * n + k];
            }
        }
        for (int j = 0; j < n; j++)
        {
            Q[i * n + j] = A[i * n + j] - c[j];
        }
    }
    for (int i = 0; i < n; i++)
    {
        double c = 0;
        for (int j = 0; j < n; j++)
        {
            c += Q[i * n + j] * Q[i * n + j];
        }
        c = sqrt(c);
        for (int j = 0; j < n; j++)
        {
            Q[i * n + j] /= c;
            R[j * n + i] *= c;
        }
    }
    return;
}
