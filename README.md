# CoDesign
## Introdcution
Implementing hardware modules in VHDL and using them for having a cryptographic algorithm in a software environment.
This project was wriiten as a final project of design automation course spring 2015.
## Project
### Phase 1
#### HE (Hardware Encoder)
```
         |    |
+-----------------------+
|        A    B         |
|       HE module       |
|          S            |
+-----------------------+
           |

            [] [] [] [] A
          + [] [] [] [] B
       + [] [] [] []    A
    + [] [] [] []       B
 + [] [] [] []          A
----------------------
[] [] [] [] [] [] [] [] S
```
#### SE (Software Encoder)
```
```
### Phase 2
#### HEM (Hardware Encoder-Multiplier)
```
         |    |
+-----------------------+
|        A    B         |
|       HEM module      |
|          S            |
+-----------------------+
           |

  [B3] [A1]            [B2] [A0]
x [B1] [A3]          x [B0] [A2]
-------------------  -------------------
[S7] [S6] [S5] [S4]  [S3] [S2] [S1] [S0]
```
#### HEA (Hardware Encodder-Adder)
```
         |    |
+-----------------------+
|        A    B         |
|       HEA module      |
|          S            |
+-----------------------+
           |

     [B0]      [B1]      [B2]      [B3]
   + [A3]    + [A2]    + [A1]    + [A0]
--------- --------- --------- ---------
[S7] [S6] [S5] [S4] [S3] [S2] [S1] [S0]
`
```
#### SE (Software Encoder)
```
```
