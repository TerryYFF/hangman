#! /usr/bin/perl

# Initiate the dictionary
@dict = &init_dict;
$length = @dict;
print("The length of the dictionary is ", $length, "\n");

# Choose the target word
$word_index = int(rand($length));
$word = @dict[$word_index];
@word_list = split(//, $word);
$word_length = @word_list;
#print("The target word is ", @word_list, "\n");

$guess = "_" x $word_length;
@guess_list = split(//, $guess);
print(@guess_list, "\n");

$count = 0;
$match = 0;
$win = 0;
@letters_guessed;
until ($count == 6 || $win == 1) {
	@letters_guessed = sort(@letters_guessed);
	print("These are the letters you have guessed: @letters_guessed\n");
	print("Please pick a letter: ");
	$letter = <STDIN>;
	chop($letter);
	if (&check_guessed($letter, join("", @letters_guessed))){
		print("The letter you entered had been guessed before.\n")
	} else {
		push(@letters_guessed, $letter);
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
	@letters_guessed = split(//, $_[1]);
	$l = @letters_guessed;
	$guessed = 0;
	for ($i = 0; $i < $l; $i++){
		if ($_[0] eq @letters_guessed[$i]) {
			$guessed = 1;
		}
	}
	$guessed;
}