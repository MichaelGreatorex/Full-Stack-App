from fastapi import APIRouter

from app.api.v1.routes._placeholders import not_implemented

router = APIRouter()


@router.get("/{session_id}", tags=["sessions"])
async def get_session(session_id: str) -> dict:
    not_implemented(f"sessions.get:{session_id}")
