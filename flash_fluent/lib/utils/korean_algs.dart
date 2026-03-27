//Conjugation and de-conjugation algorithms
import 'package:hangul/hangul.dart';

bool isVerbException(String word) {
	if(word == "안녕하세요") return true;
	return false;
}
List<String> deConjugate(String word) {
	if(isVerbException(word)) return [word];

	if(word.length >= 4) {

	if(word.substring(word.length - 3) == "이에요") {
		//Noun with "is"
		return [word.substring(word.length - 3)];
		}
	}

	if(word[word.length - 1] == "요") {
		String wordStem = word.substring(0, word.length - 1);

		// Case 1: 하다
		if(wordStem[wordStem.length - 1] == "해") {
			wordStem = wordStem.substring(0, wordStem.length - 1);
			wordStem += "하다";
			
			print(wordStem);
			return [wordStem];
		}

		//Case 2: 되다
		if(wordStem[wordStem.length - 1] == "돼") {
			wordStem = wordStem.substring(0, wordStem.length - 1);
			wordStem += "되다";
			
			print(wordStem);
			return [wordStem];
		}
		
		//Case 3: 어다
		if(wordStem[wordStem.length - 1] == "어") {
			wordStem = wordStem.substring(0, wordStem.length - 1);
			String simpleCase = wordStem + "다";

			final HangulSyllable syllable = HangulSyllable.fromString(wordStem[wordStem.length -1]);
			if(syllable.jong == "ㅆ") {
				
				HangulInput text = HangulInput(wordStem);
				text.backspace();
				String pastTense = text.toString() + "다";
				print(pastTense);
				return [pastTense];
			}
			
			print(simpleCase);
			return [simpleCase];
		}

		//Case 4: 아다
		if(wordStem[wordStem.length - 1] == "아") {
			wordStem = wordStem.substring(0, wordStem.length - 1);
			String simpleCase = wordStem + "다";
			
			print(simpleCase);
			return [simpleCase];
		}


		final HangulSyllable syllable = HangulSyllable.fromString(word[0]);
		//print(syllable.cho);
	}
	return [""];
}
