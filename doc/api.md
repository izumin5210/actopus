# API
ANCT reschedulings API

* [Class](#class)
 * [GET /classes/:id](#get-classesid)
 * [GET /classes](#get-classes)
* [Course](#course)
* [DatePeriod](#dateperiod)
* [Department](#department)
* [Lecture](#lecture)
 * [GET /lectures/:id](#get-lecturesid)
 * [GET /lectures](#get-lectures)
* [Lecturer](#lecturer)
* [Period](#period)
* [Rescheduling](#rescheduling)
 * [GET /reshedulings](#get-reshedulings)
* [Term](#term)

## Class


### Properties
* id
 * unique identifier of class
 * Example: `1`
 * Type: integer
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

### GET /classes/:id
Info for existing class.

```
GET /classes/1 HTTP/1.1
Host: api.akashi.ac.jp
```

```
HTTP/1.1 200
Content-Type: application/json
{
  "id": 1,
  "name": "1E",
  "grade": 1,
  "department": "電気情報工学科",
  "course": "情報工学コース"
}
```

### GET /classes
List existing classs.

```
GET /classes HTTP/1.1
Host: api.akashi.ac.jp
```

```
HTTP/1.1 200
Content-Type: application/json
[
  {
    "id": 1,
    "name": "1E",
    "grade": 1,
    "department": "電気情報工学科",
    "course": "情報工学コース"
  }
]
```

## Course


### Properties

## DatePeriod


### Properties
* start_time
 * time when the period start
 * Example: `"09:00:00+09:00"`
 * Type: string
* end_time
 * time when the period end
 * Example: `"10:30:00+09:00"`
 * Type: string
* taken_on
 * date when the period taken
 * Example: `"2014-12-10"`
 * Type: string

## Department


### Properties

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

### GET /lectures/:id
Info for existing lectures.

```
GET /lectures/1 HTTP/1.1
Host: api.akashi.ac.jp
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

### GET /lectures
List existing lectures.

```
GET /lectures HTTP/1.1
Host: api.akashi.ac.jp
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

## Lecturer


### Properties
* id
 * unique identifier of the lecturer
 * Example: `1`
 * Type: integer
* name
 * name of the lecture
 * Example: `"新井 イスマイル"`
 * Type: string

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
 * unique identifier of the resheduling
 * Example: `1`
 * Type: integer
* category
 * variations of reshedulings(change, cancel, extra)
 * Example: `"change"`
 * Type: string
* lecture
 * Type: object
* before
 * Type: object
* after
 * Type: object

### GET /reshedulings
List existing reshedulings.

```
GET /reshedulings HTTP/1.1
Host: api.akashi.ac.jp
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
    "before": {
      "start_time": "09:00:00+09:00",
      "end_time": "10:30:00+09:00",
      "taken_on": "2014-12-10"
    },
    "after": {
      "start_time": "09:00:00+09:00",
      "end_time": "10:30:00+09:00",
      "taken_on": "2014-12-10"
    }
  }
]
```

## Term


### Properties

