function Translit-String {
<#
.Synopsis
   Фукция транслитерация строк.
.DESCRIPTION
   Функция позволяет транслитерировать с русского или украинского алфавита на английский. А так же с русского на украинский. 
.PARAMETER inputObject
    Принемает значение через pipeline или на прямую.
.PARAMETER Lang
    Параметр выбирает условия транслитерации.
    'UA-to-EN' с украинского на английский, согласно постановлению кабинета министров от 10 января 2010 года N 55 (http://zakon1.rada.gov.ua/laws/show/55-2010-%D0%BF)
    'RU-to-EN' с русского на английский, согласно ISO 9
    'RU-to-UA' с русcкого на украинский
.NOTES
    Name: Translit-String
    Author: Дубинский Евгений
    DateCreated: 14.09.2015
.EXAMPLE
    'Глушко-Ґалаган Олена Миколаївна','Чурюмов-Герасим`юк Андрій Геннадійович' | Translit-String 
    Hlushko-Gаlаhаn Olenа Mykolаivnа 
    Churiumov-Herаsymiuk Andrii Hennаdiiovych 
    
    DESCRIPTION
    -----------
    Транслитерируем фамилию, имя, отчество с украинского на английский.
.EXAMPLE
    Translit-String 'Терешкова Валентина Владимировна','Каденюк Леонид Константинович' -Lang RU-to-EN
    Tereshkova Valentina Vladimirovna
    Kadenyuk Leonid Konstantinovich
    
    DESCRIPTION
    -----------
    Транслитерируем фамилию, имя, отчество с русского на английский.
#>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0, ValueFromPipeline=$true)]
        $InputObject,
        [Parameter(Position=1)]
        [ValidateSet('UA-to-EN','RU-to-EN','RU-to-UA')]
        $Lang = 'UA-to-EN'
    )
    BEGIN
    {
        IF ($Lang -eq 'UA-to-EN')
        {
            #UA to EN
            # Соответствие букв украинского алфавита английскому представлению 
            # согласно таблице транслитерации украинского алфавита латиницей
            # http://zakon4.rada.gov.ua/laws/show/55-2010-%D0%BF
            $Capital = @{
                'А'	= 'A'
                'Б'	= 'B'
                'В'	= 'V'
                'Г'	= 'H'
                'Ґ'	= 'G'
                'Д'	= 'D'
                'Е'	= 'E'
                'Є'	= 'Ye'
                'Ж'	= 'Zh'
                'З'	= 'Z'
                'И'	= 'Y'
                'І'	= 'I'
                'Ї'	= 'Y'
                'Й'	= 'Y'
                'К'	= 'K'
                'Л'	= 'L'
                'М'	= 'M'
                'Н'	= 'N'
                'О'	= 'O'
                'П'	= 'P'
                'Р'	= 'R'
                'С'	= 'S'
                'Т'	= 'T'
                'У'	= 'U'
                'Ф'	= 'F'
                'Х'	= 'Kh'
                'Ц'	= 'Ts'
                'Ч'	= 'Ch'
                'Ш'	= 'Sh'
                'Щ'	= 'Shch'
                'Ю'	= 'Yu'
                'Я'	= 'Ya'
                }
            $LowerCase = @{
                'а' = 'а'
                'б' = 'b'
                'в' = 'v'
                'г' = 'h'
                'ґ' = 'g'
                'д' = 'd'
                'е' = 'e'
                'є' = 'ie'
                'ж' = 'zh'
                'з' = 'z'
                'и' = 'y'
                'і' = 'i'
                'ї' = 'i'
                'й' = 'i'
                'к' = 'k'
                'л' = 'l'
                'м' = 'm'
                'н' = 'n'
                'о' = 'o'
                'п' = 'p'
                'р' = 'r'
                'с' = 's'
                'т' = 't'
                'у' = 'u'
                'ф' = 'f'
                'х' = 'kh'
                'ц' = 'ts'
                'ч' = 'ch'
                'ш' = 'sh'
                'щ' = 'shch'
                'ь' = ''
                'ю' = 'iu'
                'я' = 'ia'
            }
        }
        IF ($Lang -eq 'RU-to-UA')
        {
            #RU to UA
            $Capital = @{
                'А' = 'А'
                'Б' = 'Б'
                'В' = 'В'
                'Г' = 'Г'
                'Д' = 'Д'
                'Е' = 'Є'
                'Ё' = 'Ї'
                'Ж' = 'Ж'
                'З' = 'З'
                'И' = 'І'
                'Й' = 'Й'
                'К' = 'К'
                'Л' = 'Л'
                'М' = 'М'
                'Н' = 'Н'
                'О' = 'О'
                'П' = 'П'
                'Р' = 'Р'
                'С' = 'С'
                'Т' = 'Т'
                'У' = 'У'
                'Ф' = 'Ф'
                'Х' = 'Х'
                'Ц' = 'Ц'
                'Ч' = 'Ч'
                'Ш' = 'Ш'
                'Щ' = 'Щ'
                'Ъ' = ''
                'Ы' = 'И'
                'Ь' = 'Ь'
                'Э' = 'Е'
                'Ю' = 'Ю'
                'Я' = 'Я'
            }
            $LowerCase = @{
                'а' = 'а'
                'б' = 'б'
                'в' = 'в'
                'г' = 'г'
                'д' = 'д'
                'е' = 'є'
                'ё' = 'ї'
                'ж' = 'ж'
                'з' = 'з'
                'и' = 'і'
                'й' = 'ї'
                'к' = 'к'
                'л' = 'л'
                'м' = 'м'
                'н' = 'н'
                'о' = 'о'
                'п' = 'п'
                'р' = 'р'
                'с' = 'с'
                'т' = 'т'
                'у' = 'у'
                'ф' = 'ф'
                'х' = 'х'
                'ц' = 'ц'
                'ч' = 'ч'
                'ш' = 'ш'
                'щ' = 'щ'
                'ъ' = ''
                'ы' = 'и'
                'ь' = 'ь'
                'э' = 'е'
                'ю' = 'ю'
                'я' = 'я'
            }
        }
        IF ($Lang -eq 'RU-to-EN')
        {
            #RU to EN
            $Capital = @{
                'А' = 'A'
                'Б' = 'B'
                'В' = 'V'
                'Г' = 'G'
                'Д' = 'D'
                'Е' = 'E'
                'Ё' = 'Yo'
                'Ж' = 'Zh'
                'З' = 'Z'
                'И' = 'I'
                'Й' = 'J'
                'К' = 'K'
                'Л' = 'L'
                'М' = 'M'
                'Н' = 'N'
                'О' = 'O'
                'П' = 'P'
                'Р' = 'R'
                'С' = 'S'
                'Т' = 'T'
                'У' = 'U'
                'Ф' = 'F'
                'Х' = 'H'
                'Ц' = 'C'
                'Ч' = 'Ch'
                'Ш' = 'Sh'
                'Щ' = 'Sch'
                'Ъ' = ''
                'Ы' = 'Y'
                'Ь' = ''
                'Э' = 'E'
                'Ю' = 'Yu'
                'Я' = 'Ya'
            }
            $LowerCase = @{
                'а' = 'a'
                'б' = 'b'
                'в' = 'v'
                'г' = 'g'
                'д' = 'd'
                'е' = 'e'
                'ё' = 'yo'
                'ж' = 'zh'
                'з' = 'z'
                'и' = 'i'
                'й' = 'j'
                'к' = 'k'
                'л' = 'l'
                'м' = 'm'
                'н' = 'n'
                'о' = 'o'
                'п' = 'p'
                'р' = 'r'
                'с' = 's'
                'т' = 't'
                'у' = 'u'
                'ф' = 'f'
                'х' = 'h'
                'ц' = 'c'
                'ч' = 'ch'
                'ш' = 'sh'
                'щ' = 'sch'
                'ъ' = ''
                'ы' = 'y'
                'ь' = ''
                'э' = 'e'
                'ю' = 'yu'
                'я' = 'ya'
            }
        }
    }#END BEGIN
    PROCESS 
    {
        Foreach ( $Input in  $InputObject)
        {
            IF ( $Input -like '* *' )
            {
                $Text_Objects = $Input.Split()    
            }
            else
            {
                $Text_Objects = $Input
            }
        
            $Text_Object_Translit = $null
            foreach ( $Word in $Text_Objects )
            {
                Write-Debug 'OOps. Lets Tets'
                IF ($Word.Length -gt 1)
                {
                    $CharArray = $Word.ToCharArray()
                }
                else
                {
                    $CharArray = $Word
                }
                foreach ( $Char in $CharArray )
                {
                    IF ( $Char -eq '-' )
                    {
                        $Text_Object_Translit += '-'
                    }
                    # Определяем маленькие буквы
                    elseif ( $LowerCase.Keys -ccontains $Char)
                    {
                        $Text_Object_Translit += $LowerCase["$char"]
                    }
                    # Определяем большие буквы
                    elseif ($Capital.Keys -ccontains $Char)
                    {
                        $Text_Object_Translit += $Capital["$char"]
                    }
                }
                # Если слов больше чем одно.
                IF ($Text_Objects.Split(' ').Count -gt 1)
                {
                    $Text_Object_Translit += ' '
                }
            }
            Write-Output $Text_Object_Translit
        }
    }#END PROCESS
}#END FUNCTION