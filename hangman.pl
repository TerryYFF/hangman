use Tk;
use strict;
use warnings;

my @dict;
my $length;
my $word_index;
my $word;
my @word_list;
my $word_length;
my $guess;
my @guess_list;
my $letter;
my $i;
my $count = 0;
my $match = 0;
my $win = 0;
my @letters_guessed;
our @words;
my $guessed;
my $one;



#GUI Window. Must have TK.
# info about TK
# https://www.ibm.com/developerworks/aix/library/au-perltkmodule/index.html
# https://www.perl.com/pub/2001/03/gui.html/
# https://docstore.mik.ua/orelly/perl3/tk/ch01_04.htm

my $nmbr = 1;

my $mw = MainWindow->new;
my $game;
$mw->geometry("500x500");
$mw->title("Hangman!!!");

$mw->Label(-text => 'Do you want to play hangman?')->pack();

my $button1 = $mw->Button(-text => "Yes", -command => \&button1_sub)->pack(); #Yes Button.
my $button2 = $mw->Button(-text => "No", -command => \&button2_sub)->pack(); #No Button.

sub button1_sub {
	$game = MainWindow -> new;
	$game->title("Sub Window #1");
	$game->geometry("500x500");
	$game->title("Hangman");
	$game->Label(-text => "@guess_list")->pack();
	$game->Label(-text => "@word_list")->pack();
	$game->Label(-text => "Guess the Letter")->pack();
	$game->Entry(-background => 'black', -foreground => 'white')->pack(-side => "top");
	my $A = $game->Button(-text => "A", -command => \&letterA)->pack();
}

sub button2_sub {
  my $yesno_button = $mw->messageBox(-message => "Are you sure you don't want to play?",
                                        -type => "yesno", -icon => "question");

  if ($yesno_button eq "Yes") {
    $mw->messageBox(-message => "See you next time.", -type => "ok");
    exit;
  } else {
    $mw->messageBox(-message => "I didn't think so either.", -type => "ok");
  }
}

sub letterA{
	$game->label("YAS ITS AN A");
}


#! /usr/bin/perl
# Initiate the dictionary

@dict = &init_dict;
$length = @dict;
print("The length of the dictionary is ", $length, " words. \n");

# Choose the target word
$word_index = int(rand($length));
$word = @dict[$word_index];
@word_list = split(//, $word);
$word_length = @word_list;
#print("The target word is ", @word_list, "\n");

$guess = "_" x $word_length;
@guess_list = split(//, $guess);
print(@guess_list, "\n");



until ($count == 6 || $win == 1) {
	&hangmanDisplay();
	@letters_guessed = sort(@letters_guessed);
	print("These are the letters you have guessed: @letters_guessed\n");
	print("Please pick a letter: ");
	$letter = <STDIN>;
	print("\n");
	chop($letter);
	if (&check_guessed($letter, join("", @letters_guessed))){
		print("The letter you entered had been guessed before.\n")
	} else {
		push(@letters_guessed, $letter);
		for ($i = 0; $i < $word_length; $i++){
			if ($letter eq $word_list[$i]){
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
	&hangmanDisplay();
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
	$one = @letters_guessed;
	$guessed = 0;
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




#This is not implemented. This only runs through dictionary and reads how many lines, charaters, and words there are.



open(FILE, "dictionary.txt") or die "Could not open file: $!";

my ($lines, $words, $chars) = (0,0,0);

while (<FILE>) {
    $lines++;
    $chars += length($_);
    $words += scalar(split(/\s+/, $_));
}

print("lines=$lines words=$words chars=$chars\n");


open(FILE, "dictionary.txt") or die "Could not open file: $!";

my @Checking = <FILE>;
close FILE;
print ("lines = $lines\n");
my $random = (rand($lines));
print ("Random number = $random\n");
print $Checking[$random];

# https://stackoverflow.com/questions/782087/how-do-i-count-the-characters-words-and-lines-in-a-file-using-perl


#hashtable
#tree
