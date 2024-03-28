
Select * 
From PortfolioProject..CovidDeaths$
Where continent is not null
order by 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
Where continent is not null
order by 1,2

-- Looking at Total Cases vs Total Deaths

Select Location, date, total_cases, total_deaths,  (cast(total_deaths as float)/cast(total_cases as float))*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null 
order by 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got covid

Select Location, date, population, total_cases,   (cast(total_cases as float)/population)*100 as CasesPercentage
From PortfolioProject..CovidDeaths$
Where location like 'Russia'
and continent is not null
order by 1,2

-- Looking at Countries with Highest Infection Rate compared to population

Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((cast(total_cases as float)/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths$
Where continent is not null 
Group by location, population
order by PercentPopulationInfected Desc

--Showing Countries with Highest Death Count per Population

Select Location, MAX(cast(ROUND(Total_deaths, 0) as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null 
Group by Location
order by TotalDeathCount Desc

--Showing Total Death Count by Contients

Select continent, MAX(cast(ROUND(Total_deaths, 0) as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null 
Group by continent
order by TotalDeathCount Desc


-- GLOBAL NUMBERS

Select date, SUM(cast(ROUND(new_cases, 0) as int)) as total_cases, SUM(cast(ROUND(new_deaths, 0) as float)) as total_deaths, SUM(cast(total_deaths as float)) / SUM(cast(total_cases as float))*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where ROUND(new_cases, 0) != 0 or ROUND(new_deaths, 0) != 0
Group by date
order by 1, 2


-- Looking at Total Population vs Vaccinations


With PopvsVac(Continent, Location, Date, Population, New_vacc
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as float)) OVER (Partition by dea.location Order by dea.location,
dea.date) as RollingPeopleVaccinated
, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths$ dea 
Join PortfolioProject..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null 
order by 2, 3



