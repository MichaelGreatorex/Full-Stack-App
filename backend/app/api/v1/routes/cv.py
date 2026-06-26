from fastapi import APIRouter

router = APIRouter()


@router.post("/upload", tags=["cv"])
async def upload_cv() -> dict:
    raise NotImplementedError
