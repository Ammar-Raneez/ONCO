import React from 'react';
import { Image, View, Animated, StyleSheet } from 'react-native';

function LoginWelcome() {

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
		paddingTop: '150px',
	},
	logo: {
		height: '35px',
		resizeMode: 'contain',
	},
});
export default LoginWelcome;
