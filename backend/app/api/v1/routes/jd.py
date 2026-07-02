from fastapi import APIRouter

from app.api.v1.routes._placeholders import not_implemented

router = APIRouter()


@router.post("/upload", tags=["jd"])
async def upload_jd() -> dict:
    not_implemented("jd.upload")