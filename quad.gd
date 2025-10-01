extends MeshInstance3D

func _ready():
	mesh = build_quad()

func build_quad() -> ArrayMesh:
	var arr_mesh = ArrayMesh.new()

	# One quad = 4 vertices, 2 triangles
	var vertices = PackedVector3Array([
		Vector3(-0.5, 0, -0.5), # bottom-left
		Vector3( 0.5, 0, -0.5), # bottom-right
		Vector3( 0.5, 0,  0.5), # top-right
		Vector3(-0.5, 0,  0.5)  # top-left
	])

	var uvs = PackedVector2Array([
		Vector2(0, 1),  # bottom-left
		Vector2(1, 1),  # bottom-right
		Vector2(1, 0),  # top-right
		Vector2(0, 0)   # top-left
	])

	var indices = PackedInt32Array([
		0, 1, 2,   # first triangle
		0, 2, 3    # second triangle
	])

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arrays[Mesh.ARRAY_INDEX] = indices

	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return arr_mesh
