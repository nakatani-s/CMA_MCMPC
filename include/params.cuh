/*
define parameters for MCMPC and Systems
*/

#include <math.h>

#ifndef PARAMS_CUH
#define PARAMS_CUH

#define TIME 1
// #define dim_param 10

#define Pendulum


#ifdef Pendulum
#define dim_param 7
#define dim_state 4
#define dim_U 1

#define dim_weight_matrix 5
#define NUM_CONST 4

#else

#define dim_param 12
#define dim_state 3
#define dim_U 1

#define dim_weight_matrix 4
#define NUM_CONST 4

#endif

#define interval 0.01
#define Variavility 2.0

#define Recalc 10
#define N_OF_SAMPLES 3000
#define THREAD_PER_BLOCKS 100
#define HORIZON 100

const int dim_hat_Q = HORIZON * HORIZON;

const int CMA_mu = 100;
const float c_sigma = 0.21f;
//#define c_sigma 0.21
const float d_sigma = 5.76f;
const float Xi = 3.81f;

#define USING_THRUST

#endif
