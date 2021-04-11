# Testing Outline
## T1A3 - Terminal Application
### Terminal Trillionaire

##### Test 1 - Security Pricing Model

The Security Pricing Model is used to generate a hash containing a set of prices for a security at any given point in time. Given an input of a security 'ticker' e.g. APPL, FB, GOOGL - it will simulate a current price and historical prices (1 day ago - 1 decade ago).

The following tests must be conducted to ensure that the model runs reliably and accurately:

- Count test
    - Given a ticker argument, the method must return **five** key value pairs corresponding to the timestamps specified.
- Format test
    - The method must return key value pairs in a consistent Symbol: Float format for processing in Views.
- Benchmark test
    - The method must perform be able to perform calculations at scale, i.e. a large number such as 10,000 per second - corresponding to the number of securities available on the market and its requirements for 'real-time' price updates.
- Growth test
    - The model must simulate security prices steadily growing over time by testing each timestamp result against its predecessor.
- Volatility test
    - The prices returned by the model must fluctuate between -2% and 2% delta of the linear price calculated by the base algorithm.

##### Test 2 - User Input Error Handling

The User Input Error Handling module defines Error classes for two types of input - **Integers** and **Strings**. The method `Input.get` will prompt the user to provide input and verify against a specified regex, raising the respective error if it doesn't comply. It will also exit the application if there are too many incorrect attempts (a limit which can be specified) - to dissuade misuse of the features.

The following tests must be conducted to ensure that the model runs reliably:

- Various input tests (edge cases)
    - Given designated argument methods, the method must either return the input if validated or raise an error.
- Limit test
    - The method must exit the application if the max limit of attempts, passed in as an argument (default - 10), has been reached.