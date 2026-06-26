from fastapi import APIRouter

from app.api.v1.routes import cv, health, interview, sessions

api_router = APIRouter()

api_router.include_router(health.router)
api_router.include_router(cv.router, prefix="/cv")
api_router.include_router(interview.router, prefix="/interview")
api_router.include_router(sessions.router, prefix="/sessions")
