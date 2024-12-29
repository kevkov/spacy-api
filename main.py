from fastapi import FastAPI
import spacy

app = FastAPI()
nlp = spacy.load("en_core_web_lg")


@app.post("/parse")
def parse(text: str):
    parsed = nlp(text)
    return [token.dep_ for token in parsed]