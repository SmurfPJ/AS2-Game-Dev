shader_type canvas_item;

uniform bool active = false;

void fragment(){
	vec4 precol = texture(TEXTURE,UV);
	vec4 white = vec4(1.0,1.0,1.0,precol.a);
	vec4 newcol = precol;
	if (active == true){
		newcol = white;
	}
	COLOR = newcol;
}