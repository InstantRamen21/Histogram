#include <stdio.h>

#define BLOCK_SIZE 512
#define NUM_BLOCKS 16

__global__ void histo_kernel(unsigned int* input, unsigned int* bins, unsigned int num_elements, unsigned int num_bins)
{
     __shared__ unsigned int shared_bins[4096];
    int tid = threadIdx.x;
    for (int i = tid; i < num_bins; i += blockDim.x) {
        shared_bins[i] = 0;
    }

    __syncthreads();
    
    int gid = blockIdx.x * blockDim.x + threadIdx.x;
    int stride = blockDim.x * gridDim.x;
    
    for (int i = gid; i < num_elements; i += stride) {
        unsigned int bin = input[i];
        if (bin < num_bins) {
            atomicAdd(&shared_bins[bin], 1);
        }
    }

    __syncthreads();

    for (int i = tid; i < num_bins; i += blockDim.x) {
        atomicAdd(&bins[i], shared_bins[i]);
    }
    
}

void histogram(unsigned int* input, unsigned int* bins, unsigned int num_elements, unsigned int num_bins) {

	  histo_kernel<<<NUM_BLOCKS, BLOCK_SIZE>>>(input, bins, num_elements, num_bins);

}


