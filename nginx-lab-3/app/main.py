from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles
from fastapi import Request
import os

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")

templates = Jinja2Templates(directory="templates")

ID_INSTANCE = os.getenv("ID_INSTANCE", "None")

@app.get("/")
async def root():
    return ID_INSTANCE

@app.get("/cat", response_class=HTMLResponse)
async def picture(request: Request):
    return templates.TemplateResponse("cat.html", {"request": request})

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=8000, reload=True)
