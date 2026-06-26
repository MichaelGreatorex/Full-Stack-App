from fastapi import APIRouter

router = APIRouter()


@router.get("/{session_id}", tags=["sessions"])
async def get_session(session_id: str) -> dict:
    raise NotImplementedError
