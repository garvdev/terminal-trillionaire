# Market Pricing Objectives
# 1. Same state across all terminals => even playing field.
# 2. Continously increasing prices => imitate real world economic characteristics - inflation of asset prices as money supply increases and interest rates decrease.
# 3. Volatility => imitate price fluctuations as market determines 'correct' price of securities.

# < Time based constantly and linearly increasing price masked by volatility index unique to each security. >

# Model 1
Time.now.hash #Generate unique hash from current time as specified by Time class
# Time class - randomly generated number consistent across all user environments - algo starting point.
# Hash is completely random, can't be used to simulate security prices or they would be all over the place.

# Model 2
time = Time.now.to_f #Generate float from current time as specified by Time class, using type coercion to get integer. Always increasing time += 1 per second.
volatility = Math.sin(time) #Derive value from time variable using sine function to output integer between -1 and 1, representing level of fluctuation.
@factor = @ticker.sum #Generate unique factor based on instance of security and its characters ascii codes summed.
price = time * volatility * @factor #price of security
#This didn't work because sine function is still being used to represent delta, aka price movement. Price will fluctuate in negatives.
#We need volatility to be a percentage of reduced time function to represent a minor price fluctuation aka 99.87% or 101.05% of price on linear scale.

# Model 3
time = Time.now.to_f/1000000000 #Generate float from current time as specified by Time class, using type coercion to return a float. Always increasing time += 1 per second. Divided by a billion to normalise.
volatility = Math.sin(time)/100 + 1 #Sine-based function to output minor positive/negative deviation from linear increase in security price.
@factor = @ticker.sum #Generate unique factor based on instance of security and its characters ascii codes summed.
price = time * volatility * @factor #Price of security
#This didn't work because normalised time did not provide a meaningful variation during input to the volatility function. Move to final equation?

# Model 4
time = Time.now.to_f #Generate float from current time as specified by Time class, using type coercion to return a float. Always increasing time += 1 per second. Divided by a billion to normalise.
volatility = Math.sin(time)/100 + 1 #Sine-based function to output minor positive/negative deviation from linear increase in security price.
@factor = @ticker.sum #Generate unique factor based on instance of security and its characters ascii codes summed.
price = time/1000000000 * volatility * @factor #Price of security with time normalised after volatility has been calculated.
#Price fluctuates within bounds of -1% to 1% against linearly increasing share price of factor * normalised time.
#In this example, with vol = 1, price increases by $0.01 every 500 seconds.

# Model 5
time = Time.now.to_f #Generate float from current time as specified by Time class, using type coercion to return a float. Always increasing time += 1 per second. Divided by a billion to normalise.
volatility = Math.sin(time * @factor)/100 + 1 #Sine-based function with ticker factor to output minor positive/negative deviation from linear increase in security price.
@factor = @ticker.sum #Generate unique factor based on instance of security and its characters ascii codes summed.
price = time/1000000000 * volatility * @factor #Price of security with time normalised after volatility has been calculated.
#Introduce mutated constant factor to volatility so that each security fluctuates at a different magnitude but consistently across game-states.

#Future
#Different growth factor for each security based on ticker again. Ticker based sine function between 0.5-1.5x growth of time scale?
#Spread volatility over several hours. Larger sine function applied on top?
#Username.hash #generate hash from username to influence events (this will cause different game-states to deviate).
#Black swan events/Earnings events - Prescribe new factor with extremely low (~0.00001%) chance of significantly rebasing price of security (0.5x - 5x).
#Note that introducing chance will cause game-states to deviate as well. Perhaps a time-based threshold and fluctuation based on mutated ticker.