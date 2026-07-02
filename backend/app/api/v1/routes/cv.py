from fastapi import APIRouter

from app.api.v1.routes._placeholders import not_implemented

router = APIRouter()


@router.post("/upload", tags=["cv"])
async def upload_cv() -> dict:
    not_implemented("cv.upload")
