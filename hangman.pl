#! /usr/bin/perl

# Initiate the dictionary
@dict = &init_dict;
$length = @dict;
print("The length of the dictionary is ", $length, "\n");

# Choose the target word
$word_index = int(rand($length));
#print($word_index, "\n");
$word = @dict[$word_index];
#print("The target word is ", $word, "\n");
@word_list = split(//, $word);
$word_length = @word_list;
#print("The length of the word is ", $word_length, "\n");
#print(@word_list, "\n");

#splice(@word_list, 2, 1);
#print(@word_list, "\n");

$guess = "_" x $word_length;
@guess_list = split(//, $guess);
print(@guess_list, "\n");

$count = 0;
$match = 0;
$win = 0;
@guesses;
until ($count == 6 || $win == 1) {
	print("These are the letters you have guessed: @guesses\n");
	print("Please pick a letter: ");
	$letter = <STDIN>;
	chop($letter);
	if (&check_guessed($letter, join("", @guesses))){
		print("The letter you entered had been guessed before.\n")
	} else {
		push(@guesses, $letter);
		for ($i = 0; $i < $word_length; $i++){
			if ($letter eq @word_list[$i]){
				splice(@guess_list, $i, 1, $letter);
				$match = 1;
			}
		}
		print(@guess_list, "\n");
		if ($match == 0) {
			$count++;
		}
		$match = 0;
		if ($word eq join("", @guess_list)){
			$win = 1;
		}
	}
}

if ($win == 1){
	print("You win!\n");
} else {
	print("You lose!\n");
	print("The correct word is: ", $word, "\n");
}

# Intialize the dictionary
sub init_dict {
	local(@words);
	open(DICT, "test.txt");
#	open (DICT, "dictionary.txt");
	while ($word = <DICT>) {
		chop($word);
		@words = (@words, $word);
	}
	close (DICT);
	@words;
}

# Check if a letter has already been guessed
sub check_guessed {
	@guesses = split(//, $_[1]);
	$l = @guesses;
	$guessed = 0;
	for ($i = 0; $i < $l; $i++){
		if ($_[0] eq @guesses[$i]) {
			$guessed = 1;
		}
	}
	$guessed;
}