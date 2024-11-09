package helper

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

type ApiError struct {
	StatusCode int `json:"statusCode"`
	Msg        any `json:"message"`
}

func (e ApiError) Error() string {
	return fmt.Sprintf("%d", e.Msg)
}

func NewApiError(statusCode int, err error) ApiError {
	return ApiError{StatusCode: statusCode, Msg: err.Error()}
}

func InvalidJson() ApiError {
	return NewApiError(http.StatusBadRequest, fmt.Errorf("invalid JSON request data"))
}

type ApiFunc func(c *gin.Context) error

func Make(h ApiFunc) gin.HandlerFunc {
	return func(c *gin.Context) {
		if err := h(c); err != nil {
			if apiErr, ok := err.(ApiError); ok {
				writeJson(c, apiErr.StatusCode, apiErr)
			} else {
				errResp := map[string]any{
					"statusCode": http.StatusInternalServerError,
					"message":    "internal server error",
				}
				writeJson(c, http.StatusInternalServerError, errResp)
			}
		}
	}
}

func writeJson(c *gin.Context, status int, v any) {
	c.Header("Content-Type", "application/json")
	c.JSON(status, v)
}
