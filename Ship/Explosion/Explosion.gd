extends Node2D

func explode(exploding : bool):
	if not exploding:
		$GPUParticles2D.restart()
		
	$GPUParticles2D.set_emitting(exploding)
	$GPUParticles2D.visible = exploding
	$CpEmitter.emitting = exploding
