import React from 'react';
import { Image, View, Animated, StyleSheet } from 'react-native';

function LoginWelcome() {
	// Animation
	const position = new Animated.ValueXY({ x: 1, y: 1 });

	Animated.timing(position, {
		toValue: { x: 0.7, y: -100 },
		duration: 5000,
		useNativeDriver: true 
	}).start();

	return (
		<View style={style.container}>
			<Animated.View
				style={{
					transform: [
						{
							translateY: position.y,
						},
						{ scale: position.x },
					],
				}}
			>
				<Image style={style.logo} source={require('../../assets/oncoAssets/oncoLogo.svg')} />
			</Animated.View>
		</View>
	);
}

const style = StyleSheet.create({
	container: {
		backgroundColor: '#01CDFA',
		flex: 1,
		paddingTop: 150,
	},
	logo: {
		height: 35,
		resizeMode: 'contain',
	},
});
export default LoginWelcome;
