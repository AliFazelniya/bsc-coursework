# Mathematica Course Notes

## 📘 معرفی پروژه (Persian)

این مخزن شامل نسخه‌ی نهایی و بازآرایی‌شده‌ی جزوه‌ی دوره‌ی آموزشی **Mathematica** است که به‌صورت یک فایل LaTeX ساختارمند (شبیه یک کتابچه‌ی آموزشی) تهیه شده و خروجی PDF آن نیز در مخزن قرار دارد.

هدف از این پروژه، مستندسازی منظم مطالب دوره و ارائه‌ی یک مرجع آموزشی خوانا و قابل‌استفاده برای یادگیری و مرور نرم‌افزار Mathematica است.  
مطالب جزوه بر اساس جلسات دوره تنظیم شده و هر فصل به یک جلسه اختصاص دارد.

---

## 📂 ساختار ریپازیتوری

```text
.
├── PamphletFasi.tex        # فایل اصلی LaTeX جزوه
├── PamphletFasi.pdf        # خروجی نهایی PDF
├── pics/                   # تصاویر، نمودارها و خروجی‌های گرافیکی
├── Mathematica Files/      # فایل‌های Notebook مربوط به جلسات دوره
├── .gitignore
└── README.md
```

### توضیح پوشه‌ها و فایل‌ها

- **`PamphletFasi.tex`**  
  فایل اصلی LaTeX که متن کامل جزوه در آن نوشته شده است.

- **`PamphletFasi.pdf`**  
  خروجی نهایی کامپایل‌شده‌ی جزوه.

- **`pics/`**  
  شامل تصاویر، نمودارها و خروجی‌های استفاده‌شده در فایل LaTeX.  
  این پوشه به‌صورت کامل در مخزن قرار دارد.

- **`Mathematica Files/`**  
  شامل فایل‌های Notebook نرم‌افزار Mathematica مربوط به جلسات مختلف دوره که بر اساس سرفصل‌ها دسته‌بندی شده‌اند.  
  این فایل‌ها شامل کدها و مثال‌های عملی دوره هستند و به‌عنوان محتوای تکمیلی ارائه شده‌اند.

> توجه: در مخزن GitHub فقط فایل‌های `.tex` و `.pdf` به‌عنوان خروجی نهایی جزوه منتشر شده‌اند.

---

## ⚙️ کامپایل فایل LaTeX

برای کامپایل فایل `PamphletFasi.tex`، از **XeLaTeX** استفاده کنید:

```bash
xelatex PamphletFasi.tex
xelatex PamphletFasi.tex
```

(اجرای دوبار برای تولید صحیح فهرست مطالب و ارجاعات ضروری است.)

---

## 📝 نکات فنی

- مسیر تصاویر از پوشه‌ی `pics` تنظیم شده است.
- کدها و مسیرهای منویی نرم‌افزار Mathematica به‌صورت چپ‌به‌راست (LTR) نوشته شده‌اند.
- مثال‌ها و کدها با فونت تک‌عرض (Monospace) نمایش داده شده‌اند.
- ساختار فایل به‌گونه‌ای طراحی شده که به‌راحتی قابل توسعه و ویرایش باشد.

---

## 📘 Project Description (English)

This repository contains the final, structured LaTeX version of the **Mathematica course notes**, prepared in a booklet-style format and compiled into a PDF.

The purpose of this project is to provide a clean, organized, and readable reference for learning and reviewing the Mathematica software.  
Each chapter corresponds to a course session, following the original syllabus structure.

---

## 📂 Repository Structure

```text
.
├── PamphletFasi.tex        # Main LaTeX source file
├── PamphletFasi.pdf        # Final compiled PDF
├── pics/                   # Images and graphical outputs
├── Mathematica Files/      # Mathematica notebook files (by session)
├── .gitignore
└── README.md
```

### Details

- **`PamphletFasi.tex`**  
  Main LaTeX source containing the full course notes.

- **`PamphletFasi.pdf`**  
  Final compiled PDF output.

- **`pics/`**  
  Contains images and plots referenced in the LaTeX document.

- **`Mathematica Files/`**  
  Includes Mathematica Notebook files corresponding to the course sessions, organized by topics.  
  These files contain the original codes and examples used during the course and are provided as supplementary material.

---

## ⚙️ Compilation

To compile the LaTeX source, use **XeLaTeX**:

```bash
xelatex PamphletFasi.tex
xelatex PamphletFasi.tex
```

---

## 👤 Author

Prepared by **Ali Fazelniya**  
Computer Science Student
