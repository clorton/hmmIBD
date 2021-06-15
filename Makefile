all: hmmibd

hmmibd: hmmIBD.c
	gcc -o hmmIBD -O3 -lm -Wall hmmIBD.c

# -i input_file/population1
# -o output_file
# -I input_file/population2
# -f allele_frequency_file/population1
# -F allele_frequency_file/population2
# -g good_pairs_file/pairs_to_use
# -b bad_samples_file/samples_to_skip
# -m maximum fit iterations
# -n max N generation

test_output:
	mkdir $@

tests: hmmIBD test_output
	# single population
	./hmmIBD -i samp_data/pf3k_Cambodia_13.txt -o test_output/single_population
	# single population with frequencies ~ samp_data/output_Cambodia.*
	./hmmIBD -i samp_data/pf3k_Cambodia_13.txt -f samp_data/freqs_pf3k_Cambodia_13.txt -o test_output/single_population_with_frequencies
	# two populations
	./hmmIBD -i samp_data/pf3k_Cambodia_13.txt -I samp_data/pf3k_Ghana_13.txt -o test_output/two_populations
	# two populations, allele frequencies for population 1
	./hmmIBD -i samp_data/pf3k_Cambodia_13.txt -f samp_data/freqs_pf3k_Cambodia_13.txt -I samp_data/pf3k_Ghana_13.txt -o test_output/two_populations_one_frequency
	# two populations, allele frequencies for both populations ~ samp_data/output_Cambodia_Ghana
	./hmmIBD -i samp_data/pf3k_Cambodia_13.txt -f samp_data/freqs_pf3k_Cambodia_13.txt -I samp_data/pf3k_Ghana_13.txt -F samp_data/freqs_pf3k_Ghana_13.txt -o test_output/two_populations_with_frequencies
	# single population with good pairs file
	./hmmIBD -i samp_data/pf3k_Cambodia_13.txt -g samp_data/good_pairs.txt -o test_output/single_population_good_pairs
	# single population with bad samples file
	./hmmIBD -i samp_data/pf3k_Cambodia_13.txt -b samp_data/bad_samples.txt -o test_output/single_population_bad_samples

clean:
	rm hmmIBD
	rm test_output/*.txt
