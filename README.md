# factors_caching

To run:

`ruby ./factors.rb`

Since the output representation is up to me, I choose to have the output in sorted order, which allows me to use the cache for
different permutations of the same input array and use the same result.

To account for the "reverse factors" implementation, I chose to cache both the result of the factors calculation as well as the
reverse factors.  This allows the computation for both in a single pass (traverse the array once and calculate both results), but 
slows down the initial computation for the benefit of only having to calculate a given array (or its permuations) only once and
having both results in the future.

If there was a possibility for other questions, I would have made the cache more general and cached each individual result for each 
number in the array so that it would be easier in the future to use the cache for other results.  For example, "For a given array,
output how many entries have 2 factors."
