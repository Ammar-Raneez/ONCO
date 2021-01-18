import AccountCircleIcon from '@material-ui/icons/AccountCircle';
import LockIcon from '@material-ui/icons/Lock';
import PersonIcon from '@material-ui/icons/Person';
import React, { useEffect, useState } from 'react';
import { Alert, Animated, Button, Image, SafeAreaView, StyleSheet, Text, View } from 'react-native';
import { TextInput } from 'react-native-gesture-handler';
import LoginWelcome from './LoginWelcome';

const Login = () => {
	

	// this is to update the displayWelcome component after a given time
	useEffect(() => {
		setTimeout(() => {
			setDisplayWelcome(false);
			// fading animations
			Animated.timing(opacity, {
				toValue: 1,
				duration: 1500,
			}).start();
		}, 5000);
	}, []);

	const onClickLogin = () => {

	};

	const onClickGoogleLogin = () => {


	};
	const onClickSignUp = () => {
	
	};

	const onClickConfirmChangePass = () => {
		
		}
	};

	const onClickForgotPassword = () => {
		
	};

	return (
        <SafeAreaView style={style.container}>
            {displayWelcome ? (
				<>
					<LoginWelcome />
				</>
			) : (
				<>
					<Animated.View
						style={{
							backgroundColor: '#DEF9FF',
							flex: '1',
							justifyContent: 'space-between',
							opacity,
						}}
					>
						{/* header */}
						<View style={style.login__header}>
							<Image style={style.logo} source={require('../../assets/oncoAssets/oncoLogo.svg')} />
						</View>

						{/* welcome back */}
						<View style={style.login__welcomeBack}>
							{/* <Image style={style.whiteCloud} source={require('../../assets/oncoAssets/whiteCloud.svg')} /> */}
							<Text style={style.login__welcomeBackMessage}>Welcome back!</Text>
						</View>

						{/* login inputs */}
						<View style={style.login__inputContainer}>
							{clickedSignUp ? (
								// THIS SECTION DISPLAYS THE SIGN UP SECTION
								<>
									<Text style={style.login__inputContainerLoginDetails}>Create your new account</Text>

									{/* This is the section when the user has clicked the forget password section */}

									{/* USERNAME */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validUserName && style.redField,
											validUserName && style.blueField,
										]}
									>
										<AccountCircleIcon />
										<TextInput
											style={[style.login__inputContainerInputs, !validUserName && style.invalidTextContent]}
											onChangeText={(text) => {
												setUsername(text);
												setValidUserName(true);
											}}
											textContentType="name"
											placeholder="Username"
											value={username}
											onFocus={() => {
												if (!validUserName) {
													setUsername('');
												}
											}}
										/>
									</View>

									{/* EMAIL */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validEmail && style.redField,
											validEmail && style.blueField,
										]}
									>
										<PersonIcon />
										<TextInput
											style={[style.login__inputContainerInputs, !validEmail && style.invalidTextContent]}
											onChangeText={(text) => {
												setEmail(text);
												setValidEmail(true);
											}}
											textContentType="emailAddress"
											placeholder="Email Address"
											value={email}
											onFocus={() => {
												if (!validEmail) {
													setEmail('');
												}
											}}
										/>
									</View>

									{/* PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validPassword && style.redField,
											validPassword && style.blueField,
										]}
									>
										<LockIcon />
										<TextInput
											style={[style.login__inputContainerInputs, !validPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setPassword(text);
												setValidPassword(true);
											}}
											textContentType="password"
											placeholder="Password"
											secureTextEntry={validPassword && true}
											value={password}
											onFocus={() => {
												if (!validPassword) {
													setPassword('');
												}
											}}
										/>
									</View>
								</>
							) : !clickForgetPassword ? (
								// THIS DISPLAYS THE LOGIN SECTION ON THE APP
								<>
									<Text style={style.login__inputContainerLoginDetails}>Log in to your existing account</Text>

									{/* This is the section when the user didn't click the forget button */}

									{/* EMAIL */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validEmail && style.redField,
											validEmail && style.blueField,
										]}
									>
										<PersonIcon />
										<TextInput
											style={[style.login__inputContainerInputs, !validEmail && style.invalidTextContent]}
											onChangeText={(text) => {
												setEmail(text);
												setValidEmail(true);
											}}
											textContentType="emailAddress"
											placeholder="Email Address"
											value={email}
											onFocus={() => {
												if (!validEmail) {
													setEmail('');
												}
											}}
										/>
									</View>

									{/* PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validPassword && style.redField,
											validPassword && style.blueField,
										]}
									>
										<LockIcon />
										<TextInput
											style={[style.login__inputContainerInputs, !validPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setPassword(text);
												setValidPassword(true);
											}}
											textContentType="password"
											placeholder="Password"
											secureTextEntry={validPassword && true}
											value={password}
											onFocus={() => {
												if (!validPassword) {
													setPassword('');
												}
											}}
										/>
									</View>

									{/* FORGOT PASSWORD SECTION */}
									<Text style={style.login__forgotPasswordLink} onPress={onClickForgotPassword}>
										Forgot Password?
									</Text>
								</>
							) : (
								// THIS SECTION DISPLAYS THE CHANGE PASSWORD SECTION ON THE APP
								<>
									<Text style={style.login__inputContainerLoginDetails}>Change your password</Text>

									{/* This is the section when the user has clicked the forget password section */}

									{/* NEW PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validNewPassword && style.redField,
											validNewPassword && style.blueField,
										]}
									>
										<LockIcon />
										<TextInput
											style={[style.login__inputContainerInputs, !validNewPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setNewPassword(text);
												setValidNewPassword(true);
											}}
											textContentType="password"
											placeholder="New Password"
											secureTextEntry={validNewPassword && true}
											value={newPassword}
											onFocus={() => {
												if (!validNewPassword) {
													setNewPassword('');
												}
											}}
										/>
									</View>

									{/* CONFIRM PASSWORD */}
									<View
										style={[
											style.login__inputContainerInputsSection,
											!validConfirmPassword && style.redField,
											validConfirmPassword && style.blueField,
										]}
									>
										<LockIcon />
										<TextInput
											style={[style.login__inputContainerInputs, !validConfirmPassword && style.invalidTextContent]}
											onChangeText={(text) => {
												setConfirmPassword(text);
												setValidConfirmPassword(true);
											}}
											textContentType="password"
											placeholder="Confirm Password"
											secureTextEntry={validConfirmPassword && true}
											value={confirmPassword}
											onFocus={() => {
												if (!validConfirmPassword) {
													setConfirmPassword('');
												}
											}}
										/>
									</View>

									{/* GO BACK BUTTON */}
									<Text
										style={style.login__forgotPasswordLink}
										onPress={() => {
											setClickForgetPassword(false);
											setNewPassword('');
											setValidConfirmPassword(true);
											setValidNewPassword(true);
											setConfirmPassword('');
											setClickedSignUp(false);
										}}
									>
										Go back
									</Text>
								</>
							)}
						</View>

        </SafeAreaView>
	);
};
const style = StyleSheet.create({
	
});
export default Login;
