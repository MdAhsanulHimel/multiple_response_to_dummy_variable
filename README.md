# Multiple Response to Dummy Variable

You may often get data in the form that is not suitable for dummy coding. This often happens when a question has multiple responses. 
For example:
```{r}
df <- read.csv("multiple_response_data.csv")
df
```

| ID | earner         | jobs                     | reason                     |
|----|----------------|--------------------------|----------------------------|
| 1  | You;Mother;    | Daily labor;             | Depression;Thrill-seeking; |
| 2  | You;           | Daily labor;Housekeeper; | Thrill-seeking;            |
| 3  | Mother;        | Housekeeper;             | Curiosity;                 |
| 4  | Mother;        | Housekeeper;Job holder;  | Depression;                |
| 5  | You;Father;    | Daily labor;             | Thrill-seeking;            |
| 6  | Mother;        | Daily labor;Job holder;  | Curiosity;                 |
| 7  | You;           | Job holder;              | Depression;Peer pressure;  |
| 8  | Mother;        | Daily labor;             | Experimenting;             |
| 9  | Sibling;       | Daily labor;             | Experimenting;Curiosity;   |
| 10 | Father;Mother; | Daily labor;             | Peer pressure;             |

A simple split method doesn't work in this case for any of the variables. 
Using the function `MultToDummy()` you can easily make dummy variables for any of the variables on the dataset.

## Function Description

To use the function, run:
```{r}
source("https://raw.githubusercontent.com/MdAhsanulHimel/multiple_response_to_dummy_variable/master/MultToDummy.R")
```
**Arguments:**   
- x: Specify the column as vector element.   
- splitby: default ';'. Specify which delimiter will be used to split the multiple responses.   
- bind: default TRUE. Shows the original column along with the dummy variables.    

Please [Contact me](https://rebrand.ly/ahsanul-linkedin) if you have any feature suggestions. 

## Example

```{r}
MultToDummy(df$jobs, split = ";", bind = TRUE)
```

| jobs                     | jobs.Daily_labor | jobs.Housekeeper | jobs.Job_holder |
|--------------------------|------------------|------------------|-----------------|
| Daily labor;             | 1                | 0                | 0               |
| Daily labor;Housekeeper; | 1                | 1                | 0               |
| Housekeeper;             | 0                | 1                | 0               |
| Housekeeper;Job holder;  | 0                | 1                | 1               |
| Daily labor;             | 1                | 0                | 0               |
| Daily labor;Job holder;  | 1                | 0                | 1               |
| Job holder;              | 0                | 0                | 1               |
| Daily labor;             | 1                | 0                | 0               |
| Daily labor;             | 1                | 0                | 0               |
| Daily labor;             | 1                | 0                | 0               |

```{r}
MultToDummy(df$reason, split = ";", bind = FALSE)
```

| reason.Depression | reason.Thrill_seeking | reason.Curiosity | reason.Peer_pressure | reason.Experimenting |
|-------------------|-----------------------|------------------|----------------------|----------------------|
| 1                 | 1                     | 0                | 0                    | 0                    |
| 0                 | 1                     | 0                | 0                    | 0                    |
| 0                 | 0                     | 1                | 0                    | 0                    |
| 1                 | 0                     | 0                | 0                    | 0                    |
| 0                 | 1                     | 0                | 0                    | 0                    |
| 0                 | 0                     | 1                | 0                    | 0                    |
| 1                 | 0                     | 0                | 1                    | 0                    |
| 0                 | 0                     | 0                | 0                    | 1                    |
| 0                 | 0                     | 1                | 0                    | 1                    |
| 0                 | 0                     | 0                | 1                    | 0                    |

