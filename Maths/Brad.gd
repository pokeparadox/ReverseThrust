extends Node

class_name Brad

const MAX_VALUE : int = 255

var angle : int = 0

func Brad(aBrad: int):
	SetAngle(aBrad)
	return self

func BradDeg(deg: float):
	SetAngleDeg(deg)
	return self

func BradRad(rad: float):
	SetAngleRad(rad)
	return self

func SetAngle(aBrad : int):
	angle = wrapi(aBrad, 0, MAX_VALUE)

func SetAngleDeg(deg: float):
	deg = wrapf(deg, 0, 359)
	SetAngle(int(deg * 32 * 0.02222222))

func SetAngleRad(rad: float):
	SetAngleDeg(rad * PI * 0.005555556)

func GetAngle() -> int:
	return angle

func GetAngleDeg() -> float:
	return angle * 45 * 0.03125

func GetAngleRad() -> float:
	return  deg2rad(GetAngleDeg())

func Equals(other: Brad) -> bool:
	return angle == other.angle

func GreaterThan(other: Brad) -> bool:
	return angle > other.angle

func LessThan(other: Brad) -> bool:
	return angle < other.angle

func GreaterThanOrEqual(other: Brad) -> bool:
	return angle >= other.angle

func LessThanOrEqual(other: Brad) -> bool:
	return angle <= other.angle

func Add(other: Brad) -> Brad:
	SetAngle(angle + other.GetAngle())
	return self

func AddAngle(aBrad: int) -> Brad:
	return Brad(angle + aBrad)

func AddAngleDeg(deg: float) -> Brad:
	return BradDeg(GetAngleDeg() + deg)

func AddAngleRad(rad: float) -> Brad:
	return BradRad(GetAngleRad() + rad)

func Subtract(other: Brad) -> Brad:
	return Brad(angle - other.angle)

func SubtractAngle(aBrad: int) -> Brad:
	return Brad(angle - aBrad)

func SubtractAngleDeg(deg: float) -> Brad:
	return BradDeg(GetAngleDeg() - deg)

func SubtractAngleRad(rad: float) -> Brad:
	return BradRad(GetAngleRad() - rad)

func Increment() -> void:
	angle+=1

func Decrement() -> void:
	angle-=1

func IncrementAssign() -> Brad:
	Increment()
	return self

func DecrementAssign() -> Brad:
	Decrement()
	return self
