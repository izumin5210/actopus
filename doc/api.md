# actopus API
A schema for ANCT reschedulings API

* [Class](#class)
 * [GET /api/v1/classes/:id](#get-apiv1classesid)
 * [GET /api/v1/classes](#get-apiv1classes)
* [Lecture](#lecture)
 * [GET /api/v1/lectures/:id](#get-apiv1lecturesid)
 * [GET /api/v1/lectures](#get-apiv1lectures)
* [Period](#period)
* [Rescheduling](#rescheduling)
 * [GET /api/v1/reschedulings](#get-apiv1reschedulings)
* [Timetable](#timetable)
 * [GET /api/v1/classes/:id/timetable](#get-apiv1classesidtimetable)

## Class


### Properties
* id
 * unique identifier of class
 * Example: `"1e"`
 * Type: string
* name
 * name of the class
 * Example: `"1E"`
 * Type: string
* grade
 * grade of the class
 * Example: `1`
 * Type: integer
* department
 * a name of the department
 * Example: `"電気情報工学科"`
 * Type: string
* course
 * a name of the course
 * Example: `"情報工学コース"`
 * Type: string

### GET /api/v1/classes/:id
Info for existing class.

```
GET /api/v1/classes/1e HTTP/1.1
Host: 
```

```
HTTP/1.1 200
Content-Type: application/json
{
  "id": "1e",
  "name": "1E",
  "grade": 1,
  "department": "電気情報工学科",
  "course": "情報工学コース"
}
```

### GET /api/v1/classes
List existing classs.

```
GET /api/v1/classes HTTP/1.1
Host: 
```

```
HTTP/1.1 200
Content-Type: application/json
[
  {
    "id": "1e",
    "name": "1E",
    "grade": 1,
    "department": "電気情報工学科",
    "course": "情報工学コース"
  }
]
```

## Lecture


### Properties
* id
 * unique identifier of lecture
 * Example: `1`
 * Type: string
* name
 * name of the lecture
 * Example: `"プログラミング I"`
 * Type: string
* grade
 * grade of the class
 * Example: `1`
 * Type: integer
* department
 * a name of the department
 * Example: `"電気情報工学科"`
 * Type: string
* course
 * a name of the course
 * Example: `"情報工学コース"`
 * Type: string
* special_target
 * the target of the lecture(overseasStudent or female)
 * Example: `"overseasStudent"`
 * Type: string
* periods
 * Type: array
* lecturers
 * Type: array
* code
 * the unique code of lecture
 * Example: `2014121002101231110200`
 * Type: string

### GET /api/v1/lectures/:id
Info for existing lectures.

```
GET /api/v1/lectures/1 HTTP/1.1
Host: 
```

```
HTTP/1.1 200
Content-Type: application/json
{
  "id": 1,
  "name": "プログラミング I",
  "grade": 1,
  "department": "電気情報工学科",
  "course": "情報工学コース",
  "special_target": "overseasStudent",
  "periods": [
    {
      "start_time": "09:00:00+09:00",
      "end_time": "10:30:00+09:00",
      "wday": 1
    }
  ],
  "lecturers": [
    "新井 イスマイル"
  ],
  "code": 2014121002101231110200
}
```

### GET /api/v1/lectures
List existing lectures.

```
GET /api/v1/lectures HTTP/1.1
Host: 
```

```
HTTP/1.1 200
Content-Type: application/json
[
  {
    "id": 1,
    "name": "プログラミング I",
    "grade": 1,
    "department": "電気情報工学科",
    "course": "情報工学コース",
    "special_target": "overseasStudent",
    "periods": [
      {
        "start_time": "09:00:00+09:00",
        "end_time": "10:30:00+09:00",
        "wday": 1
      }
    ],
    "lecturers": [
      "新井 イスマイル"
    ],
    "code": 2014121002101231110200
  }
]
```

## Period


### Properties
* start_time
 * time when the period start
 * Example: `"09:00:00+09:00"`
 * Type: string
* end_time
 * time when the period end
 * Example: `"10:30:00+09:00"`
 * Type: string
* wday
 * wday when the period taken
 * Example: `1`
 * Type: integer

## Rescheduling


### Properties
* id
 * unique identifier of the rescheduling
 * Example: `1`
 * Type: integer
* category
 * variations of reschedulings(change, cancel, extra)
 * Example: `"change"`
 * Type: string
* lecture
 * Type: object
* before_period
 * the preriod that lecture has taken
 * Type: object
* after_period
 * the preriod that lecture has taken
 * Type: object

### GET /api/v1/reschedulings
List existing reschedulings.

```
GET /api/v1/reschedulings HTTP/1.1
Host: 
```

```
HTTP/1.1 200
Content-Type: application/json
[
  {
    "id": 1,
    "category": "change",
    "lecture": {
      "id": 1,
      "name": "プログラミング I",
      "grade": 1,
      "department": "電気情報工学科",
      "course": "情報工学コース",
      "special_target": "overseasStudent",
      "periods": [
        {
          "start_time": "09:00:00+09:00",
          "end_time": "10:30:00+09:00",
          "wday": 1
        }
      ],
      "lecturers": [
        "新井 イスマイル"
      ],
      "code": 2014121002101231110200
    },
    "before_period": {
      "start_time": "09:00:00+09:00",
      "end_time": "10:30:00+09:00",
      "taken_on": "2014-12-10"
    },
    "after_period": {
      "start_time": "09:00:00+09:00",
      "end_time": "10:30:00+09:00",
      "taken_on": "2014-12-10"
    }
  }
]
```

## Timetable


### Properties
* cells
 * Type: array
* beginning_of_week
 * the date representing the start this week
 * Example: `"2014-12-15"`
 * Type: string
* end_of_week
 * the date representing the end this week
 * Example: `"2014-12-19"`
 * Type: string

### GET /api/v1/classes/:id/timetable
List class' timetables.

```
GET /api/v1/classes/1e/timetable HTTP/1.1
Host: 
```

```
HTTP/1.1 200
Content-Type: application/json
{
  "cells": [
    {
      "category": "change",
      "scheduled_on": "2014-12-16",
      "lecture": {
        "id": 1,
        "name": "プログラミング I",
        "grade": 1,
        "department": "電気情報工学科",
        "course": "情報工学コース",
        "special_target": "overseasStudent",
        "periods": [
          {
            "start_time": "09:00:00+09:00",
            "end_time": "10:30:00+09:00",
            "wday": 1
          }
        ],
        "lecturers": [
          "新井 イスマイル"
        ],
        "code": 2014121002101231110200
      },
      "period": {
        "start_time": "09:00:00+09:00",
        "end_time": "10:30:00+09:00"
      },
      "rescheduling_id": 1
    }
  ],
  "beginning_of_week": "2014-12-15",
  "end_of_week": "2014-12-19"
}
```

