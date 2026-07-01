from fastapi import APIRouter

router = APIRouter()


@router.post("/upload", tags=["jd"])
async def upload_jd() -> dict:
    raise NotImplementedError