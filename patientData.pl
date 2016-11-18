#!/bin/perl

## CIS 140 PR7
## Created by Steve Langewicz II
## 11-17-2016

use 5.16.3;
#use warnings;
use Time::localtime;

my (@PINs, @lastNames, @firstNames, @middleNames, @DOBs, @ages, @ailments);
my @insurances = ();
my ($userEnteredData, $PIN, $menuChoice, $year);
#my ($sec,$min,$hour,$mday,$mon,$year) = localtime();

use constant TRUE => 1;
use constant MAX_MONTH =>12;
use constant MAX_DAY =>31;
use constant MAX_YEAR =>2200;
use constant MIN_YEAR =>1900;

$userEnteredData = 0;
$PIN = 1;
$menuChoice;
$year = 2016;# localtime($year) + 1900;

sub main {
        menu();

}

main();

sub menu{
        while ($menuChoice != [1] || $menuChoice != [2] || $menuChoice == 0){
                system ("clear");
                print "\n\n\n---------Welcome--------";
                print "\n\n 1.) Enter new patient information";
                print "\n 2.) Process Billing";
                print "\n 3.) Quit";
                print "\n\n\nChoose a number to get started: ";
                chomp ($menuChoice = <STDIN>);
                if (!(defined $menuChoice) || $menuChoice < 1 || $menuChoice > 3){
                        say "Choose a NUMBER between 1 and 3!";
                        sleep 2;
                        system ("clear");
                        $menuChoice = 0;
                }
                if ($menuChoice == 1){
                        newData();
                }
                if ($menuChoice == 2){
                        billing();
                }
                if ($menuChoice == 3){
                        exit;
                }
        }
}


sub newData{
        my ($month, $day, $birthYear, $insuranceQuestion);
        system ("clear");
        $PINs[$PIN] = $PIN; #stores pin into data array
        print "\n\nYou are now entering information for patient ID $PIN.\n\nPlease enter the patient's First name:";
        chomp ($firstNames[$PIN] = <STDIN>);
        print "\n\nEnter the patient's Middle name: ";
        chomp ($middleNames[$PIN] = <STDIN>);
        print "\n\nEnter the patient's Last name: ";
        chomp ($lastNames[$PIN] = <STDIN>);
        print "\n\n\nYou will now enter the patient's date of birth.";
        while (!(defined $month)){
                print "\n\nEnter the Month of birth (MM): ";
                chomp ($month = <STDIN>);
                if ($month <= 0 || $month > MAX_MONTH || $month !~ /[0-9]/){
                        say "Incorrect. Enter a number between 1 and 12: ";
                        sleep 2;
                        $month = undef;
                        system ("clear");
                }
        }
        while (!(defined $day)){
                print "\n\nEnter the Day of birth (DD): ";
                chomp ($day = <STDIN>);
                if ($day <= 0 || $day > MAX_DAY || $day !~ /[0-9]/){
                        say "Incorrect. Enter a number between 1 and 31: ";
                        sleep 2;
                        $day = undef;
                        system ("clear");
                }
        }
        while (!(defined $birthYear)){
                print "\n\nEnter the Year of birth (YYYY): ";
                chomp ($birthYear = <STDIN>);
                if ($birthYear < MIN_YEAR || $birthYear > MAX_YEAR || $birthYear =~ /[a-z]/){
                        say "Incorrect. Enter a year between 1900 and the current year: ";
                        sleep 2;
                        $birthYear = undef;
                        system ("clear");
                }
        }
        $DOBs[$PIN] = "$month-$day-$birthYear";
        $ages[$PIN] = $year - $birthYear;
        while (!(defined $insuranceQuestion) || $insuranceQuestion =~ /[9]/ || $insuranceQuestion !~ /[0-9]/){
                print "\n\nDoes the patient have insurance coverage? (1=YES, 0=NO): ";
                chomp ($insuranceQuestion = <STDIN>);
                if ($insuranceQuestion !~ /[0-9]/ || $insuranceQuestion > 1 || $insuranceQuestion < 0){
                        say "Incorrect. Please enter only 1 for YES or 0 for NO: ";
                        sleep 2;
                        $insuranceQuestion = 9;
                        system ("clear");
                }

        }
        if ($insuranceQuestion == 1){
                print "\n\nEnter the name of the Insurance Company: ";
                chomp ($insurances[$PIN] = <STDIN>);
        } else {
                $insurances[$PIN] = 'None';
 }
        print "\n\nEnter the patient's ailment(s): ";
        $ailments[$PIN] = <STDIN>;
        print "\n\n\nPatient $firstNames[$PIN] $middleNames[$PIN] $lastNames[$PIN], age $ages[$PIN], has been assigned Patient Id Number $PIN. The patient's ailment(s) is as follows: $ailments[$PIN].";
        sleep 6;
        $PIN++;
        $userEnteredData = 1;
}

sub billing{
        my ($numOfPIN, $numNoInsurance, $i);
        $numOfPIN = @PINs;
        if ($userEnteredData =~ /[0]/){
                system ("clear");
                say "\n\n\nNo patient data has been entered.";
                sleep 3;
                return;
        }
        if ($userEnteredData =~ /[1]/){
                system ("clear");
                say "\n |  PIN  |  First Name  |  Middle Name  |  Last Name  |  Date of Birth  |  Age  |  Ailments  |";
                for ($i = 0; $i < $numOfPIN; $i++){
                        if ($insurances[$i] =~ /^[None]{4}$/x){
                                say " |   $PINs[$i]   |   $firstNames[$i]   |   $middleNames[$i]   |   $lastNames[$i]   |   $DOBs[$i]   |   $ages[$i]   |   $ailments[$i]";
                        }
                }
        }
        sleep 15;
