from fastapi import APIRouter

router = APIRouter()


@router.post("/start", tags=["interview"])
async def start_interview() -> dict:
    raise NotImplementedError


@router.post("/answer", tags=["interview"])
async def submit_answer() -> dict:
    raise NotImplementedError
