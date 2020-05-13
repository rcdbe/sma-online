from nltk.stem import WordNetLemmatizer; wnl = WordNetLemmatizer()
from nltk.corpus import stopwords;stop = set(stopwords.words('english'))
from nltk import sent_tokenize as sTokens
from nltk import word_tokenize as wTokens
import re, json
from tqdm import tqdm
from bz2 import BZ2File as bz2

def print_Topics(model, feature_names, Top_Topics, n_top_words):
    for topic_idx, topic in enumerate(model.components_[:Top_Topics]):
        print("Topic #%d:" %topic_idx)
        print(" ".join([feature_names[i]
                        for i in topic.argsort()[:-n_top_words - 1:-1]]))

def LoadBZ2(data_file):
    # Efficiently Loading Data - It'll take around 12" for 6Gb Data
    with bz2(data_file, "r") as bzData:
        Tweets = []
        for i, line in tqdm(enumerate(bzData)):
            try:
                tweet = json.loads(line.strip())
                Tweets.append(cleanUp(tweet['text']).strip())
            except:
                pass
    return Tweets

def LoadTxt(file):
    df=open(file,"r",encoding="utf-8", errors='replace')
    Doc = df.readlines();df.close()
    return [line.strip() for line in tqdm(Doc)]

def strip_non_ascii(string):
    ''' Returns the string without non ASCII characters''' #isascii = lambda s: len(s) == len(s.encode())
    stripped = (c for c in string if 0 < ord(c) < 127)
    return ''.join(stripped)

def isplural(word,wnl):
    return wnl.lemmatize(word,'n') # Will return == word kalau "word" bukan plural nouns & return singular otherwise

def cleanUp(txt,stop=stop):
    clean_sentences, clean_txt = [], txt.lower()
    urlPattern = re.compile(r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+')
    try:
        sentenceS = sTokens(clean_txt)
        for sentence in sentenceS:
            S = re.sub(urlPattern,' ',sentence.strip())
            tokenS = wTokens(S)
            clean_token = []
            for word in tokenS:
                W = isplural(strip_non_ascii(word))
                if len(W>1) and W not in stop:
                    clean_token.append(W)
            clean_sentences.append(' '.join(clean_token))
        clean_txt = '. '.join(clean_sentences)
    except:
        pass
    return clean_txt