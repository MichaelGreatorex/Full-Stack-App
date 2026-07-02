from fastapi import HTTPException, status


def not_implemented(endpoint_name: str) -> None:
    raise HTTPException(
        status_code=status.HTTP_501_NOT_IMPLEMENTED,
        detail=f"{endpoint_name} is not implemented yet",
    )
