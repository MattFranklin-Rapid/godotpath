// chromatic aberration
//---------------------------------

shader_type canvas_item;

uniform vec2 r_displacement = vec2(3.0, 0.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-3.0, 0.0);


void fragment()
{
	float r = texture(TEXTURE, UV + vec2(SCREEN_PIXEL_SIZE*r_displacement), 0.0).r;
	float g = texture(TEXTURE, UV + vec2(SCREEN_PIXEL_SIZE*g_displacement), 0.0).g;
	float b = texture(TEXTURE, UV + vec2(SCREEN_PIXEL_SIZE*b_displacement), 0.0).b;
	float a = 1.0;
	
	if(texture(TEXTURE, UV).r < 0.2 && texture(TEXTURE, UV).g < 0.2 && texture(TEXTURE, UV).b < 0.2){
		r = 0.9;
		b = 0.3;
		g = 0.0;
		a = 0.9;
	}else{
		a = 0.0;
	}
	COLOR = vec4(r, g, b, a);
}