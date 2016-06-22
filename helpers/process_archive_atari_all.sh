#!/bin/bash

wget https://archive.org/download/DatabarRunningPlannerAtari/Databar_Running_Planner_Atari.pdf
./process_archive_atari.sh Databar_Running_Planner_Atari.pdf 3 end
wget https://archive.org/download/DatabarHealthAssessmentAtari/Databar_Health_Assessment_Atari.pdf
./process_archive_atari.sh Databar_Health_Assessment_Atari.pdf 3 end
wget https://archive.org/download/DatabarOscarsMatchAtari/Databar_Oscars_Match_Atari.pdf
./process_archive_atari.sh Databar_Oscars_Match_Atari.pdf 3 end
wget https://archive.org/download/DatabarFinancialQuizAtari/Databar_Financial_Quiz_Atari.pdf
./process_archive_atari.sh Databar_Financial_Quiz_Atari.pdf 3 end
wget https://archive.org/download/DatabarTriangleSolutionsAtari/Databar_Triangle_Solutions_Atari.pdf
./process_archive_atari.sh Databar_Triangle_Solutions_Atari.pdf 3 end
wget https://archive.org/download/DatabarProgramInBasicAtari/Databar_Program_In_Basic_Atari.pdf
./process_archive_atari.sh Databar_Program_In_Basic_Atari.pdf 3 end
wget https://archive.org/download/DatabarWordHabitsAtari/Databar_Word_Habits_Atari.pdf
./process_archive_atari.sh Databar_Word_Habits_Atari.pdf 3 end
wget https://archive.org/download/DatabarMathChallengeOneAtari/Databar_Math_Challenge_One_Atari.pdf
./process_archive_atari.sh Databar_Math_Challenge_One_Atari.pdf 3 end
wget https://archive.org/download/DatabarReturnOnInvestmentAtari/Databar_Return_On_Investment_Atari.pdf
./process_archive_atari.sh Databar_Return_On_Investment_Atari.pdf 3 end
wget https://archive.org/download/DatabarTheLawAndYouAtari/Databar_The_Law_and_You_Atari.pdf
./process_archive_atari.sh Databar_The_Law_and_You_Atari.pdf 3 end
wget https://archive.org/download/DatabarFourInARowAtari/Databar_Four_In_A_Row_Atari.pdf
./process_archive_atari.sh Databar_Four_In_A_Row_Atari.pdf 3 end

wget "https://archive.org/download/DatabarOscarsSpellerAtari/Databar_Oscar's_Speller_Atari.pdf"
mv "Databar_Oscar's_Speller_Atari.pdf" Databar_Oscars_Speller_Atari.pdf
./process_archive_atari.sh Databar_Oscars_Speller_Atari.pdf 3 end
