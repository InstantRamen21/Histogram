Assume you perform a histogram operation on an array of size N, 16 blocks, block size of B and 1024 bins.
First, let's assume a privatized histogram implementation.

1. How many global memory reads are performed during the histogram kernel?
"N" number of global memory reads are performed during the histogram kernel.

2. How many global memory writes are performed during the histogram kernel?
16 blocks × 1024 bins = 16,384 global memory writes are performed during the histogram kernel.

3. How many atomic operations are performed in shared memory?
"N" number of atomic operations are performed in shared memory.

4. How many atomic operations are performed in global memory?
16 blocks × 1024 bins = 16,384 atomic operations are performed in global memory.

5. Now assume we have a naive implementation of reduction (without privatization). How many global memory atomic operations are performed in total?
"N" number of global memory atomic operations are performed in total.
