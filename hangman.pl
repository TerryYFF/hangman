use Tk;
use strict;
use warnings;

my @dict;
my $length;
my $word_index;
my $word;
my $word_length;
my $guess;
my $letter;
my $i;
my $count = 0;
my $match = 0;
my $win = 0;
my @letters_guessed;

#Hangman
#
# Display punctuation in game.  _ _ _ _ ' _ (Fixed)
# Case Insensitive. A, a should be the same. (Fixed)


# Ideas for creative project
#
# Processing.
# EG. When it has this letter at the end of the string, it does this etc.
# Variable number of arguments to a function.
# Dereferencing
# Hashing
# Dynamic Arrays
# Glue Things together
# Variable number arguments
# Text Processing
# regular expression parsing.



#GUI Window. Must have TK.
# info about TK
# https://www.ibm.com/developerworks/aix/library/au-perltkmodule/index.html
# https://www.perl.com/pub/2001/03/gui.html/
# https://docstore.mik.ua/orelly/perl3/tk/ch01_04.htm

my $mw;
my $game;
my $GuessList;
my $LettersGuessed;

# sub GUI {
# 	$mw = MainWindow->new;
# 	$mw->geometry("500x500");
# 	$mw->title("Hangman!!!");
#
# 	$mw->Label(-text => 'Do you want to play hangman?')->pack();
#
# 	my $button1 = $mw->Button(-text => "Yes", -command => \&button1_sub)->pack(); #Yes Button.
# 	my $button2 = $mw->Button(-text => "No", -command => \&button2_sub)->pack(); #No Button.
# }


# Window that pops up after you press Yes
sub GUI {
	$game = MainWindow -> new;
	$game->geometry("500x500");
	$game->title("Hangman");
	$GuessList = $game->Label(-text => "$guess")->pack();
	$LettersGuessed = $game->Label(-text => "Letters Guessed: @letters_guessed")->pack();
	my $A = $game->Button(-text => "A", -command => [\&letter, 'a'])->pack(-side => 'left');
	my $B = $game->Button(-text => "B", -command => [\&letter, 'b'])->pack(-side => 'left');
	my $C = $game->Button(-text => "C", -command => [\&letter, 'c'])->pack(-side => 'left');
	my $D = $game->Button(-text => "D", -command => [\&letter, 'd'])->pack(-side => 'left');
	my $E = $game->Button(-text => "E", -command => [\&letter, 'e'])->pack(-side => 'left');
}


# # Window that pops after you press No
# sub button2_sub {
#   my $yesno_button = $mw->messageBox(-message => "Are you sure you don't want to play?",
#                                         -type => "yesno", -icon => "question");
#
#   if ($yesno_button eq "Yes") {
#     $mw->messageBox(-message => "See you next time.", -type => "ok");
#     exit;
#   } else {
#     $mw->messageBox(-message => "I didn't think so either.", -type => "ok");
#   }
# }

# Letter Button takes a letter as a parameter
sub letter{
	$letter = $_[0];
	&CheckLetter();
}

sub CheckLetter {
	if (&check_guessed($letter, join("", @letters_guessed))){
		$LettersGuessed -> configure(-text => "Letters Guessed: @letters_guessed");
		$GuessList -> configure(-text => "$guess");
	} else {
		push(@letters_guessed, $letter);
		@letters_guessed = sort(@letters_guessed);
		$LettersGuessed -> configure(-text => "Letters Guessed: @letters_guessed");
		for ($i = 0; $i < $word_length; $i++){
			if ($letter eq substr($word, $i, 1)){
				substr($guess, $i, 1, $letter);
				$match = 1;
			} elsif (uc($letter) eq substr($word, $i, 1)) {
				substr($guess, $i, 1, uc($letter));
				$match = 1;
			}
		}
		$GuessList -> configure(-text => "$guess");
		if ($match == 0) {
			$count++;
		}
		$match = 0;
		if ($word eq $guess){
			$win = 1;
		}
	}
}


#! /usr/bin/perl
# Initiate the dictionary
#my $size = `wc -l dictionary.txt`;
my $size = 20;
#$size =~ s/\D//g;
print("The size of the file is $size\n");

# Choose the target word
$word_index = int(rand($size));

$word = &fetch_word($word_index);
chop($word);
chop($word);
$word_length = length($word);
$guess = "_" x $word_length;
if (index($word, "'") != -1){
	substr($guess, index($word, "'"), 1, "'");
}
print($guess, "\n");



&GUI();

# until ($count == 6 || $win == 1) {
# 	&hangmanDisplay();
# 	print("These are the letters you have guessed: @letters_guessed\n");
# 	print("Please pick a letter: ");
# 	# $letter = <STDIN>;
# 	# print("\n");
# 	# chop($letter);
# 	if (&check_guessed($letter, join("", @letters_guessed))){
# 		$game->Label(-text => "These are the letters you have guessed: @letters_guessed")->pack();
# 	} else {
# 		push(@letters_guessed, $letter);
# 		for ($i = 0; $i < $word_length; $i++){
# 			if ($letter eq $word_list[$i]){
# 				splice(@guess_list, $i, 1, $letter);
# 				$match = 1;
# 			}
# 		}
# 		print(@guess_list, "\n");
# 		if ($match == 0) {
# 			$count++;
# 		}
# 		$match = 0;
# 		if ($word eq join("", @guess_list)){
# 			$win = 1;
# 		}
# 	}
# }

if ($win == 1){
	print("You win!\n");
} else {
	&hangmanDisplay();
	print("You lose!\n");
	print("The correct word is: ", $word, "\n");
}

sub fetch_word {
	open(DICT, "dictionary.txt") or die "Could not open file: $!";
	my $target = <DICT>;
	my $counter = 0;
	until ($counter == $_[0]){
		$target = <DICT>;
		$counter ++;
	}
	$target;
}


# Check if a letter has already been guessed
sub check_guessed {
	@letters_guessed = split(//, $_[1]);
	my $one = @letters_guessed;
	my $guessed = 0;
	for ($i = 0; $i < $one; $i++) {
		if ($_[0] eq $letters_guessed[$i]) {
			$guessed = 1;
		}
	}
	$guessed;
}

sub hangmanDisplay {
	if ($count == 0){
		&hangman1Display();
	} elsif ($count == 1) {
		&hangman2Display();
	} elsif ($count == 2) {
		&hangman3Display();
	} elsif ($count == 3) {
		&hangman4Display();
	} elsif ($count == 4) {
		&hangman5Display();
	} elsif ($count == 5) {
		&hangman6Display();
	} elsif ($count == 6) {
		&hangman7Display();
	}
}


sub hangman1Display {
        print "  -------\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
			}

sub hangman2Display {
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
			}

sub hangman3Display {
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |     |\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
			}

sub hangman4Display {
        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
			}

sub hangman5Display {

        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|/\n";
        print "  |\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
			}

sub hangman6Display {

        print "  -------\n";
        print "  |     |\n";
        print "  |     o\n";
        print "  |    \\|/\n";
        print "  |    / \n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
			}

sub hangman7Display {
        print "  -------\n";
        print "  |     |\n";
        print "  |     x\n";
        print "  |    \\|/\n";
        print "  |    / \\\n";
        print "  |\n";
        print "  |\n";
        print "--|----\n";
	}

	MainLoop;

