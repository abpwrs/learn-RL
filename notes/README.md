What is [Reinforcement Learning](https://en.wikipedia.org/wiki/Reinforcement_learning) & Intro to Markov Processes
==================================================================================================================

#### Topics Covered

-   What is RL
-   Markov Process
-   Markov Reward Process
-   Markov Decision Process

What is RL?
-----------

Reinforcement Learning is:

-   A sub-field of machine learning that focuses on how a software agent
    takes actions in an environment to maximize a reward function
-   An approach that incorporates the time dimension of ML problems
-   A method that falls somewhere between supervised and unsupervised
    learning in terms

[Markov Process](https://en.wikipedia.org/wiki/Markov_chain)
------------------------------------------------------------

In a Markov Process we have a system that contains a set space
$\mathbf{S}$ that is finite, and a transition matrix $\mathbf{T}$. In
order for a system to be a Markov Process, it must statisfy the [Markov
Property](https://en.wikipedia.org/wiki/Markov_property). The Markov
Property states that the future system state depends only on the current
state, and not any sequence of states. This type of system can be
thought of as memoryless. I like to think of these as finite state
machines (FSM) where each transition between two states has an
associated probability of occuring.

Example Transition Probability Matrix:

   Current State   sunny next   rainy next
  --------------- ------------ ------------
       sunny          0.8          0.2
       rainy          0.1          0.9

[Markov Reward Process](https://en.wikipedia.org/wiki/Markov_reward_model)
--------------------------------------------------------------------------

A Markov Reward Process builds off of a Markov Process by adding a
reward $R$ to every state transition.

The **reward** is just a scalar, that could be positive or negative.

Example Reward Matrix:

   Current State   sunny next   rainy next
  --------------- ------------ ------------
       sunny          0.5           -5
       rainy           5           -2.2

The **return**, $G$, at time $t$ is the sum of subsequent rewards, where
subsequent rewards are multiplied by a discount factor $\gamma$ raised
to the power of the index of the summation $k$.

$$G_t = \sum_{k=0}^{\infty} \gamma^k R_{t + (k + 1)}$$
$$0 \le \gamma \le 1$$

Intuition for gamma:\
If gamma is 1, the return is the sum of all future rewards. This would
correspond to perfect visibility of all future rewards.\
if gamma is 0, the return is only the current reward. This would
correspond to no insight into furture rewards.\
Conventionally gamma is in between, like 0.9

The **value of state** is the mathematical expectation, or average of
lots of possible chains. This provides a less volatile metric for reward
at any given state

$$\mathbf{V}(s) = \mathbb{E}[ G | S_t = s ]$$

[Markov Decision Process](https://en.wikipedia.org/wiki/Markov_decision_process)
--------------------------------------------------------------------------------

A Markov Decision Process adds an `Action Dimension` to the transition
matrix, which allows the agent to modify the probability of transition
based on the action selected. The index of the `Action Dimension` is
selected by the **policy**, which is the porbabilty of an action being
selected given a curent state.A Markov Reward process can be thought of
as a special case of and MDP, where the policy function is **fixed**.

The probability of an action occuring given a current state.\
Policy Function:

$$\pi(a | s) = P[A_t = a | S_t = s] $$

[OpenAI](http://www.openai.com) [Gym API](http://gym.openai.com/docs/)
======================================================================

#### Topics Covered

-   Components of RL
    -   Agent
    -   Environment
    -   Actions
    -   Observations
    -   Policy

``` {.python}
import random
```

The Agent
---------

The **agent** is a person or a thing that takes an active role. The
agent is the implementor of the **policy** which decides what action to
take at each time step. The agent decides what action to take based on
the observation that it recieves from the environment.

``` {.python}
# a niave agent that makes a random choice regardless of observations
class Agent:
    def __init__(self):
        self.total_reward = 0.0

    def step(self, env):
        current_obs = env.get_observation()
        actions = env.get_actions()
        reward = env.action(random.choice(actions))
        self.total_reward += reward
```

The Environment
---------------

The **environment** is a model of the world external to the **agent**.
The environment is responsible for providing the agent with
**observations** and **rewards**. The environment state will change
depending on the agents actions.\
OpenAI Environment class has 2 main attributes `action_space` and
`observation_space` as well as two main methods `reset()` and `step()`.
Each of the attributes represent their respective spaces. The reset
method returns the environment to it's initial state. The step method is
the central method of the Environment class and does the following
things:

-   Takes an input that is the step to be taken and executes it
-   Gets new observations after this action
-   Gets the reward gained by this step
-   Provides and indication that the step is complete

``` {.python}
class Environment:
    def __init__(self):
        self.steps_left = 10

    # observations will change based on agent behavior
    # this informs the agents decisions
    def get_observation(self):
        return [0.0, 0.0, 0.0]
    
    # action set should likely change based on the agents actions
    def get_actions(self):
        return [0, 1]

    # likely some 'win condition'
    def is_done(self):
        return self.steps_left == 0

    def action(self, action):
        if self.is_done():
            raise Exception("Game is over")
        self.steps_left -= 1
        return random.random()
```

``` {.python}
# object instantiation
env = Environment()
agent = Agent()

# the NIAVE agent will make random choices for 10 steps
while not env.is_done():
    agent.step(env)

print("Total reward: %.4f" % agent.total_reward)
```

    Total reward: 3.4977

OpenAI ships with tons of pre-build environments to test on. A list can
be found [here](https://gym.openai.com/envs).

Agent Actions
-------------

The action space can be either discrete or continous, or a combination
of both. `Discrete Action Space` (pushing a button, moving in a grid)
only one option is possible at time. `Continous Action Space` (run 9
degrees left, turn a nob 0-1). The environment could also have multiple
actions that can be performed simultaneously.

Observations
------------

Observations are information that the `Environment` provides to the
`Agent`. Observations can be as simple as a couple of numbers, or as
complex as multiple videos or images.\
OpenAI Observation types are as follows: Discrete, Box, Tuple.
`Discrete` is a set of mutually exclusive possibilities. `Box` is an
n-dimensional tensor. `Tuple` allows us to group together multiple space
classes.

Gym Wrappers & Monitors
-----------------------

Just know that these exist and help extend OpenAI functionality in
generic ways. [readthedocs.io](http://gym.openai.com/docs/)

Deep Learning w/ [PyTorch](https://pytorch.org/docs/stable/index.html)
======================================================================

``` {.python}
```

The Cross-Entropy Method
========================

``` {.python}
```

Tabular Learning & the Bellman Equation
=======================================

``` {.python}
```

Deep Q Networks (DQN)
=====================

DQN Extensions
==============

``` {.python}
```

Stock Trading Example
=====================

``` {.python}
```

Policy Gradients
================

``` {.python}
```

The Actor-Critic Method
=======================

``` {.python}
```

Asynchronus Advantage Actor-Critic
==================================

``` {.python}
```

Chat-Bot Example
================

``` {.python}
```

Web Navigation
==============

``` {.python}
```

Continuous Action Space
=======================

``` {.python}
```

Trust Regions
=============

``` {.python}
```

Black Box Optimization
======================

``` {.python}
```

Beyond Model-Free
=================

``` {.python}
```

AlphaGo Zero
============

``` {.python}
```
