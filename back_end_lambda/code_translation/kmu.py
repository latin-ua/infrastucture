dictionary = {
    'А': 'A',
    'а': 'a',
    'Б': 'B',
    'б': 'b',
    'В': 'V',
    'в': 'v',
    'Г': 'H',
    'г': 'h',
    'Ґ': 'G',
    'ґ': 'g',
    'Д': 'D',
    'д': 'd',
    'Е': 'E',
    'е': 'e',
    'Є': 'Ye',
    'є': 'ie',
    'Ж': 'Zh',
    'ж': 'zh',
    'З': 'Z',
    'з': 'z',
    'И': 'Y',
    'и': 'y',
    'І': 'I',
    'і': 'i',
    'Ї': 'Yi',
    'ї': 'i',
    'Й': 'Y',
    'й': 'i',
    'К': 'K',
    'к': 'k',
    'Л': 'L',
    'л': 'l',
    'М': 'M',
    'м': 'm',
    'Н': 'N',
    'н': 'n',
    'О': 'O',
    'о': 'o',
    'П': 'P',
    'п': 'p',
    'Р': 'R',
    'р': 'r',
    'С': 'S',
    'с': 's',
    'Т': 'T',
    'т': 't',
    'У': 'U',
    'у': 'u',
    'Ф': 'F',
    'ф': 'f',
    'Х': 'Kh',
    'х': 'kh',
    'Ц': 'Ts',
    'ц': 'ts',
    'Ч': 'Ch',
    'ч': 'ch',
    'Ш': 'Sh',
    'ш': 'sh',
    'Щ': 'Shch',
    'щ': 'shch',
    'Ю': 'Yu',
    'ю': 'iu',
    'Я': 'Ya',
    'я': 'ia',
    'ь': '',
    "'": '',
}

dictionary_first_letter = {
    'Є': 'Ye',
    'є': 'ye',
    'Ї': 'Yi',
    'ї': 'yi',
    'Й': 'Y',
    'й': 'y',
    'Ю': 'Yu',
    'ю': 'yu',
    'Я': 'Ya',
    'я': 'ya',
}


diphthong = [
    ("зг", "zgh"),
    ("Зг", "Zgh"),
    ("зГ", "zGH"),
    ("ЗГ", "ZGH")
]


def text_translate_kmu(text):
    word_list = text.split()
    translated_text = []

    for word in word_list:
        translated_word = word_translate(word)
        translated_text.append(translated_word)

    translated_text = " ".join(translated_text)
    return translated_text


def word_translate(word):

    translated_word = []

    for cyrillic, latin in diphthong:
        word = word.replace(cyrillic, latin)

    for index, letter in enumerate(word):
        if index == 0 and letter in dictionary_first_letter:
            translated_word.append(dictionary_first_letter[letter])
        elif letter in dictionary:
            translated_word.append(dictionary[letter])
        else:
            translated_word.append(letter)

    translated_word = "".join(translated_word)
    return translated_word
    